# frozen_string_literal: true

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
    # @TODO
    # - Centroids
    # - GeoNames
    {
      'Title': {
        destination: 'dc_title_s',
        delimited: false,
        transformation_method: nil
      },
      'Alternative Title': {
        destination: 'dct_alternativeTitle_sm',
        delimited: true,
        transformation_method: nil
      },
      'Description': {
        destination: 'dc_description_s',
        delimited: false,
        transformation_method: nil
      },
      'Language': {
        destination: 'dc_language_sm',
        delimited: true,
        transformation_method: nil
      },
      'Publisher': {
        destination: 'dc_publisher_sm',
        delimited: true,
        transformation_method: nil
      },
      'Creator': {
        destination: 'dc_creator_sm',
        delimited: true,
        transformation_method: nil
      },
      'Genre': {
        destination: 'b1g_genre_sm',
        delimited: true,
        transformation_method: nil
      },
      'Subject': {
        destination: 'dc_subject_sm',
        delimited: true,
        transformation_method: nil
      },
      'Keyword': {
        destination: 'b1g_keyword_sm',
        delimited: true,
        transformation_method: nil
      },
      'Date Issued': {
        destination: 'dct_issued_s',
        delimited: false,
        transformation_method: nil
      },
      'Temporal Coverage': {
        destination: 'dct_temporal_sm',
        delimited: true,
        transformation_method: nil
      },
      'DateRange': {
        destination: 'b1g_date_range_drsim',
        delimited: true,
        transformation_method: nil
      },
      'Solr Year': {
        destination: 'solr_year_i',
        delimited: false,
        transformation_method: nil
      },
      'Spatial Coverage': {
        destination: 'dct_spatial_sm',
        delimited: true,
        transformation_method: nil
      },
      'Bounding Box': {
        destination: 'solr_geom',
        delimited: false,
        transformation_method: nil
      },
      'Format': {
        destination: 'dc_format_s',
        delimited: false,
        transformation_method: nil
      },
      'Type': {
        destination: 'dc_type_sm',
        delimited: true,
        transformation_method: nil
      },
      'Geometry Type': {
        destination: 'layer_geom_type_s',
        delimited: false,
        transformation_method: nil
      },
      'Information': {
        destination: 'dct_references_s',
        delimited: false,
        transformation_method: 'build_dct_references'
      },
      'Download': {
        destination: 'dct_references_s',
        delimited: false,
        transformation_method: 'build_dct_references'
      },
      'FeatureServer': {
        destination: 'dct_references_s',
        delimited: false,
        transformation_method: 'build_dct_references'
      },
      'MapServer': {
        destination: 'dct_references_s',
        delimited: false,
        transformation_method: 'build_dct_references'
      },
      'ImageServer': {
        destination: 'dct_references_s',
        delimited: false,
        transformation_method: 'build_dct_references'
      },
      'Image': {
        destination: 'b1g_image_ss',
        delimited: false,
        transformation_method: nil
      },
      'Identifier': {
        destination: 'dc_identifier_s',
        delimited: false,
        transformation_method: nil
      },
      'Provenance': {
        destination: 'dct_provenance_s',
        delimited: false,
        transformation_method: nil
      },
      'Code': {
        destination: 'b1g_code_s',
        delimited: false,
        transformation_method: nil
      },
      'Is Part Of': {
        destination: 'dct_isPartOf_sm',
        delimited: true,
        transformation_method: nil
      },
      'Status': {
        destination: 'b1g_status_s',
        delimited: false,
        transformation_method: nil
      },
      'Accrual Method': {
        destination: 'dct_accrualMethod_s',
        delimited: false,
        transformation_method: nil
      },
      'Date Accessioned': {
        destination: 'b1g_dateAccessioned_s',
        delimited: false,
        transformation_method: nil
      },
      'RIghts': {
        destination: 'dc_rights_s',
        delimited: false,
        transformation_method: nil
      },
      'Suppressed': {
        destination: 'suppressed_b',
        delimited: false,
        transformation_method: nil
      },
      'Child': {
        destination: 'b1g_child_record_b',
        delimited: false,
        transformation_method: nil
      }
    }
  end
end
