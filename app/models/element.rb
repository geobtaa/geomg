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

  # Solr Schema List
  def self.list
    Element.all.map(&:solr_field)
  end

  # Indexable value
  def index_value
    self.index_transformation_method || self.solr_field
  end
end
