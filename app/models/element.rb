class Element < ApplicationRecord

  # Scopes
  scope :importable, -> { where(import: true) }
  scope :exportable, -> { where(export: true) }
  scope :indexable, -> { where(index: true) }

  # Find by solr_schema_name shortcut
  def self.at(field)
    Element.find_by_solr_schema_name(field)
  end

  # Solr Schema List
  def self.list
    Element.all.collect{ |c| c.solr_schema_name }
  end

  # Indexable value
  def index_value
    self.index_transformation_method || self.solr_schema_name
  end
end
