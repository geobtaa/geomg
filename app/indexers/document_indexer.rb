# frozen_string_literal: true

# Solr indexing for our document class. Still a work in progress.
class DocumentIndexer < Kithe::Indexer
  configure do
    # Kithe
    to_field 'model_pk_ssi', obj_extract('id') # the actual db pk, a UUID

    # GeoBlacklight
    to_field 'geoblacklight_version', literal('1.0')

    # Form
    # Identification
    # - Descriptive
    to_field 'dc_title_s', obj_extract('title')
    to_field 'dct_alternativeTitle_sm', obj_extract('dct_alternativeTitle_sm')
    to_field 'dc_description_s', obj_extract('dc_description_s')
    to_field 'dc_language_sm', obj_extract('dc_language_sm')

    # - Credits
    to_field 'dc_creator_sm', obj_extract('dc_creator_sm'), transform(->(v) { v.presence ? v : nil })
    to_field 'dc_publisher_sm', obj_extract('dc_publisher_sm'), transform(->(v) { v.presence ? v : nil })

    # - Categories
    to_field 'b1g_genre_sm', obj_extract('b1g_genre_sm')
    to_field 'dc_subject_sm', obj_extract('dc_subject_sm'), transform(->(v) { v.presence ? v : nil })
    to_field 'b1g_keyword_sm', obj_extract('b1g_keyword_sm')

    # - Temporal
    to_field 'dct_issued_s', obj_extract('dct_issued_s')
    to_field 'dct_temporal_sm', obj_extract('dct_temporal_sm'), transform(->(v) { v.presence ? v : nil })
    to_field 'b1g_date_range_drsim', obj_extract('b1g_date_range_drsim'), transform(->(v) { v.presence ? v : nil })
    to_field 'solr_year_i', obj_extract('solr_year_i')

    # - Spatial
    to_field 'dct_spatial_sm', obj_extract('dct_spatial_sm'), transform(->(v) { v.presence ? v : nil })
    to_field 'b1g_geonames_sm', obj_extract('b1g_geonames_sm')
    to_field 'solr_geom', obj_extract('solr_geom')
    to_field 'b1g_centroid_ss', obj_extract('b1g_centroid_ss')

    # Distribution
    # - Object
    to_field 'dc_type_sm', obj_extract('dc_type_sm')
    to_field 'layer_geom_type_s', obj_extract('layer_geom_type_s')
    to_field 'dc_format_s', obj_extract('dc_format_s')

    # - Access Links
    # - Geospatial Web Services
    # - Images
    # - Metadata
    to_field 'dct_references_s', obj_extract('references_json')
    to_field 'b1g_image_ss', obj_extract('b1g_image_ss')

    # Administrative
    # - Codes
    to_field 'dc_identifier_s', obj_extract('dc_identifier_s')
    to_field 'layer_slug_s', obj_extract('layer_slug_s')
    to_field 'dct_provenance_s', obj_extract('dct_provenance_s')
    to_field 'b1g_code_s', obj_extract('b1g_code_s')
    to_field 'dct_isPartOf_sm', obj_extract('dct_isPartOf_sm')

    # - Status
    to_field 'b1g_status_s', obj_extract('b1g_status_s')
    to_field 'dct_accrualMethod_s', obj_extract('dct_accrualMethod_s')
    to_field 'dct_accrualPeriodicity_s', obj_extract('dct_accrualPeriodicity_s')
    to_field 'b1g_dateAccessioned_s', obj_extract('b1g_dateAccessioned_s')
    to_field 'b1g_dateRetired_s', obj_extract('b1g_dateRetired_s')

    # - Accessibility
    to_field 'dc_rights_s', obj_extract('dc_rights_s')
    to_field 'dct_accessRights_sm', obj_extract('dct_accessRights_sm'), transform(->(v) { v.presence ? v : nil })
    to_field 'suppressed_b', obj_extract('suppressed_b')
    to_field 'b1g_child_record_b', obj_extract('b1g_child_record_b')

    to_field 'layer_modified_dt' do |rec, acc|
      acc << rec.updated_at.utc.iso8601 if rec.updated_at
    end

    # May want to switch to or add a 'date published' instead, right
    # now we only have date added to DB, which is what we had in sufia.
    to_field 'date_created_dtsi' do |rec, acc|
      acc << rec.created_at.utc.iso8601 if rec.created_at
    end

    to_field 'date_modified_dtsi' do |rec, acc|
      acc << rec.updated_at.utc.iso8601 if rec.updated_at
    end
  end
end
