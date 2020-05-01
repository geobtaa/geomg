class ImportBtaa < Import
  # validations, constants and methods


  # Solr Field => Hard Value
  def default_mappings
    [
      {'geoblacklight_version': '1.0'}
    ]
  end

  # CSV Source Header => Destination Solr Field
  def assumed_mappings
    mappings = []
    if self.mappings.find_by(destination_field: 'dc_identifier_s')
      mappings << {self.mappings.find_by(destination_field: 'dc_identifier_s').source_header => 'layer_slug_s'}
    end

    mappings
  end
end
