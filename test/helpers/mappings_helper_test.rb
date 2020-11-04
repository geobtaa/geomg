# frozen_string_literal: true

require 'test_helper'

class MappingsHelperTest < ActionView::TestCase
  test 'attribute_collection' do
    assert_equal(
      attribute_collection,
      ['Discard', '', :b1g_centroid_ss, :b1g_child_record_b, :b1g_code_s, :b1g_dateAccessioned_s, :b1g_dateRetired_s, :b1g_date_range_drsim, :b1g_genre_sm, :b1g_geonames_sm, :b1g_image_ss, :b1g_keyword_sm, :b1g_status_s, :dc_creator_sm, :dc_description_s, :dc_format_s, :dc_identifier_s, :dc_language_sm, :dc_publisher_sm, :dc_rights_s, :dc_source_sm, :dc_subject_sm, :dc_title_s, :dc_type_sm, :dct_accessRights_sm, :dct_accrualMethod_s, :dct_accrualPeriodicity_s, :dct_alternativeTitle_sm, :dct_isPartOf_sm, :dct_issued_s, :dct_provenance_s, :dct_references_s, :dct_spatial_sm, :dct_temporal_sm, :layer_geom_type_s, :layer_id_s, :layer_slug_s, :solr_geom, :solr_year_i, :suppressed_b]
    )
  end

  test 'mapping_suggestion - exists' do
    assert_equal(
      mapping_suggestion('Language'),
      'dc_language_sm'
    )
  end

  test 'mapping_suggestion - does not exist' do
    assert_equal(
      mapping_suggestion('Does Not Exist'),
      false
    )
  end

  test 'delimiter_suggestion - exists' do
    assert_equal(
      delimiter_suggestion('Language'),
      true
    )
  end

  test 'delimiter_suggestion - does not exist' do
    assert_equal(
      delimiter_suggestion('Does Not Exist'),
      false
    )
  end
end
