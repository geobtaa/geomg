# frozen_string_literal: true

# MappingsHelper
module MappingsHelper
  def attribute_collection
    attrs = Document.attr_json_registry.attribute_names.sort
    attrs.prepend('')
    attrs.prepend('Discard')
    attrs
  end

  def mapping_suggestion(header)
    if Geomg.field_mappings_btaa.include?(header.to_sym)
      Geomg.field_mappings_btaa[header.to_sym][:destination]
    else
      false
    end
  end

  def delimiter_suggestion(header)
    if Geomg.field_mappings_btaa.include?(header.to_sym)
      Geomg.field_mappings_btaa[header.to_sym][:delimited]
    else
      false
    end
  end
end
