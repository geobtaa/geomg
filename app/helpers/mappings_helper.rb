# frozen_string_literal: true

# MappingsHelper
module MappingsHelper
  def attribute_collection
    Document.attr_json_registry.attribute_names
  end

  def mapping_suggestion(header)
    Geomg.field_mappings_btaa[header.to_sym][:destination]
  end

  def delimiter_suggestion(header)
    Geomg.field_mappings_btaa[header.to_sym][:delimited]
  end
end
