# frozen_string_literal: true

# Import BTAA
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
    # No longer assuming identfier == slug
    # [
    #   { 'dc_identifier_s': 'layer_slug_s' }
    # ]
    # Return empty array
    []
  end

  # Derived Values
  def derived_mappings
    [
      { 'b1g_centroid_ss':
        {
          field: 'solr_geom',
          method: 'derive_b1g_centroid_ss'
        } }
    ]
  end

  def solr_geom_mapping(geom)
    # "W,S,E,N" convert to "ENVELOPE(W,E,N,S)"
    w, s, e, n = geom.split(',')
    "ENVELOPE(#{w},#{e},#{n},#{s})"
  end

  def derive_b1g_centroid_ss(args)
    data_hash = args[:data_hash]
    field = args[:field]

    w, e, n, s = wens_matches(data_hash[field])
    "#{((n.to_f + s.to_f) / 2)},#{((e.to_f + w.to_f) / 2)}"
  end

  def wens_matches(data_hash_field)
    matches = data_hash_field.match(/\(([^)]+)\)/)
    matches.captures[0].split(',')
  end
end
