class Element < ApplicationRecord

  # Scopes
  scope :formable, -> { where(formable: true) }
  scope :importable, -> { where(importable: true) }
  scope :exportable, -> { where(exportable: true) }
  scope :indexable, -> { where(indexable: true) }

  # Find by solr_field shortcut
  def self.at(field)
    Element.find_by_solr_field(field)
  end

  # Element Field List (Labels as Symbols)
  def self.list
    @list ||= Element.all.map{ |e| e.label.parameterize(separator: '_').to_sym }
  end

  # Index value
  def index_value
    self.index_transformation_method || self.solr_field
  end

  # Export value
  def export_value
    self.export_transformation_method || self.solr_field
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

  # @TODO - override respond_to?
  # def self.respond_to?(m, include_private = false)
  # if list.include?(m)
  #    true
  #  else
  #    super
  #  end
  # end
end
