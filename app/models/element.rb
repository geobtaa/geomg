class Element < ApplicationRecord
  serialize :html_attributes

  # Scopes
  scope :formable, -> { where(formable: true) }
  scope :importable, -> { where(importable: true) }
  scope :exportable, -> { where(exportable: true) }
  scope :indexable, -> { where(indexable: true) }

  # Validations
  # @TODO
  # - validate for presence required fields (title, field_type, etc.)
  # - validate field_type (string, boolean, text)

  # Find by solr_field shortcut
  def self.at(field)
    Element.find_by_solr_field(field)
  end

  # Element Field List (Labels as Symbols)
  def self.list
    @list ||= Element.all.map{ |e| e.label.parameterize(separator: '_').to_sym }
  end

  def constantized_label
    self.label.parameterize(separator: '_').upcase
  end

  # Index value
  def index_value
    if self.index_transformation_method.present?
      self.index_transformation_method
    else
      self.solr_field
    end
  end

  # Export value
  def export_value
    if self.export_transformation_method.present?
      self.export_transformation_method
    else
      self.solr_field
    end
  end

  def self.label_nocase(label)
    Element.where("LOWER(label) = ?", label.to_s.tr('_', ' ').downcase).first
  end

  # Class Level - Method Missing
  # ex. :title => "Title"
  def self.method_missing(m, *args, &block)
    if list.include?(m)
      self.label_nocase(m)
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

  # @TODO - override respond_to?
  # def self.respond_to?(m, include_private = false)
  # if list.include?(m)
  #    true
  #  else
  #    super
  #  end
  # end
end
