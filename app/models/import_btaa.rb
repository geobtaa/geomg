# frozen_string_literal: true

# Import BTAA
class ImportBtaa < Import
  # validations, constants and methods

  def mapping_configuration
    Geomg.field_mappings_btaa
  end

  def klass_delimiter
    '|'
  end

  # Solr Field => Hard Value
  def default_mappings
    [
      { gbl_mdVersion_s: 'Aardvark' }
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
      {
        dcat_centroid:
          {
            field: 'dcat_bbox',
            method: 'derive_dcat_centroid'
          }
      }
    ]
  end

  # Required Values
  # Key / Default Value
  def required_mappings
    [
      { b1g_status_s: 'Active' }
    ]
  end

  def derive_dcat_centroid(args)
    data_hash = args[:data_hash]
    field = args[:field]

    return if data_hash[field].blank?

    w, s, e, n = data_hash[field].split(',')
    "#{(n.to_f + s.to_f) / 2},#{(e.to_f + w.to_f) / 2}"
  end
end
