class Element < ApplicationRecord
  serialize :html_attributes

  # Scopes
  scope :formable, -> { where(formable: true) }
  scope :importable, -> { where(importable: true) }
  scope :exportable, -> { where(exportable: true) }
  scope :indexable, -> { where(indexable: true) }

  # Callbacks
  def after_save
    reload!
  end

  # Validations
  # @TODO
  validates :label, :solr_field, :field_type, presence: true
  # - validate field_type (string, boolean, text)

  FIELD_TYPES = [
    "string",
    "text",
    "integer",
    "boolean",
    "datetime"
  ]

  # Find by solr_field shortcut
  def self.at(field)
    Element.find_by_solr_field(field)
  end

  # Element Field List (Labels as Symbols)
  def self.list
    @list ||= Element.all.map { |e| e.label.parameterize(separator: "_").to_sym }
  end

  def constantized_label
    label.parameterize(separator: "_").upcase
  end

  # Index value
  def index_value
    if index_transformation_method.present?
      index_transformation_method
    else
      solr_field
    end
  end

  # Export value
  def export_value
    if export_transformation_method.present?
      export_transformation_method
    else
      solr_field
    end
  end

  def self.label_nocase(label)
    Element.where("LOWER(label) = ?", label.to_s.tr("_", " ").downcase).first
  end

  # Class Level - Method Missing
  # ex. :title => "Title"
  def self.method_missing(m, *args, &block)
    if list.include?(m)
      label_nocase(m)
    else
      super
    end
  end

  def self.sort_elements(id_array)
    transaction do
      logger.debug { id_array.inspect }
      id_array.each_with_index do |elm_id, i|
        Element.update(elm_id, position: i)
      end
    end
  end

  def self.respond_to_missing?(method_name, include_private = false)
    label_nocase(method_name).present? || super
  end
end
