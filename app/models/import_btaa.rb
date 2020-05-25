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

  # Derived Values
  def derived_mappings
    [
      { 'b1g_centroid_ss':
        {
          field: 'solr_geom',
          method: 'derive_b1g_centroid_ss'
        }
      }
    ]
  end

  def dct_references_mappings
    {
      "Download": "download",
      "FeatureServer": "arcgis_feature_layer",
      "ImageServer": "arcgis_image_map_layer",
      "Information": "documentation_external",
      "MapServer": "arcgis_dynamic_map_layer"
    }
  end

  def solr_geom_mapping(geom)
    # "W,S,E,N" convert to "ENVELOPE(W,E,N,S)"
    w,s,e,n = geom.split(',')
    "ENVELOPE(#{w},#{e},#{n},#{s})"
  end

  def derive_b1g_centroid_ss(args)
    data_hash = args[:data_hash]
    field = args[:field]

    matches = data_hash[field].match(/\(([^)]+)\)/)

    w,e,n,s = matches.captures[0].split(',')
    centerlat = (n.to_f + s.to_f) / 2
    centerlong = (e.to_f + w.to_f) / 2

    centroid = "#{centerlat},#{centerlong}"

    centroid
  end
end
