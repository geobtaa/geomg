class ImportBtaa < Import
  # validations, constants and methods


  # Solr Field => Hard Value
  def default_mappings
    [
      { 'geoblacklight_version': '1.0' }
    ]
  end

  # Copy Value from Field to Field
  def assumed_mappings
    [
      { 'dc_identifier_s': 'layer_slug_s' }
    ]
  end

  def dct_references_mappings
    {
      "Download": "http://schema.org/downloadUrl",
      "FeatureServer": "urn:x-esri:serviceType:ArcGIS#FeatureLayer",
      "ImageServer": "urn:x-esri:serviceType:ArcGIS#ImageMapLayer",
      "Information": "http://schema.org/url",
      "MapServer": "urn:x-esri:serviceType:ArcGIS#DynamicMapLayer"
    }
  end
end
