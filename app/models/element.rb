class Element < ApplicationRecord

  # Find by solr_schema_name shortcut
  def self.at(field)
    Element.find_by_solr_schema_name(field)
  end

  def self.list
    Element.all.collect{ |c| c.solr_schema_name }
  end
end
