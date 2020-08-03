# frozen_string_literal: true

require 'test_helper'

class MappingsHelperTest < ActionView::TestCase
  test 'attribute_collection' do
    assert_equal(
      attribute_collection,
      ["", :dc_title_s, :dct_alternativeTitle_sm, :dc_description_s, :dc_language_sm, :dc_creator_sm, :dc_publisher_sm, :b1g_genre_sm, :dc_subject_sm, :b1g_keyword_sm, :dct_issued_s, :dct_temporal_sm, :b1g_date_range_drsim, :solr_year_i, :dct_spatial_sm, :b1g_geonames_sm, :solr_geom, :b1g_centroid_ss, :dc_type_sm, :layer_geom_type_s, :dc_format_s, :dct_references_s, :b1g_image_ss, :dc_identifier_s, :layer_slug_s, :dct_provenance_s, :b1g_code_s, :dct_isPartOf_sm, :b1g_status_s, :dct_accrualMethod_s, :dct_accrualPeriodicity_s, :b1g_dateAccessioned_s, :b1g_dateRetired_s, :dc_rights_s, :dct_accessRights_sm, :suppressed_b, :b1g_child_record_b]
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
