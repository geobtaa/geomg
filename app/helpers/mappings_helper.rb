# frozen_string_literal: true

# MappingsHelper
module MappingsHelper
  def attribute_collection
    attrs = Element.importable.map(&:solr_field).sort
    attrs.prepend("")
    attrs.prepend("Discard")
    attrs
  end

  def mapping_suggestion(import, header)
    if import.mapping_configuration.include?(header.to_sym)
      import.mapping_configuration[header.to_sym][:destination]
    else
      false
    end
  end

  def delimiter_suggestion(import, header)
    if import.mapping_configuration.include?(header.to_sym)
      import.mapping_configuration[header.to_sym][:delimited]
    else
      false
    end
  end
end
