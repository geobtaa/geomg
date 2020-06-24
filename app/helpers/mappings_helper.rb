# frozen_string_literal: true

# MappingsHelper
module MappingsHelper
  def attribute_collection
    Document.attr_json_registry.attribute_names
  end

  def mapping_suggestion(header)
    default_field_mappings_btaa[header.to_sym][:destination]
  end

  def delimiter_suggestion(header)
    default_field_mappings_btaa[header.to_sym][:delimited]
  end

  def default_field_mappings_btaa
    eval(
      File.read(
        Rails.root.join('config/geomg/field_mappings_btaa.rb')
      )
    )
  end
end
