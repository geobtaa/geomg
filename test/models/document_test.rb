# frozen_string_literal: true

require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  def setup
    @document = Document.new
  end

  # Attrs
  test 'responds to title' do
    assert_respond_to @document, :title
  end

  test 'responds to publication_state' do
    assert_respond_to @document, :publication_state
    assert_respond_to @document, :current_state
  end

  test 'responds to import' do
    assert_respond_to @document, :import
  end

  test 'kithe_indexable_mapper' do
    assert_respond_to @document, :kithe_indexable_mapper
  end

  test 'responds to B1G attributes' do
    # Form
    # Identification
    # - Descriptive
    assert_respond_to @document, :dc_title_s
    assert_respond_to @document, :dct_alternativeTitle_sm
    assert_respond_to @document, :dc_description_s
    assert_respond_to @document, :dc_language_sm

    # - Credits
    assert_respond_to @document, :dc_creator_sm
    assert_respond_to @document, :dc_publisher_sm

    # - Categories
    assert_respond_to @document, :b1g_genre_sm
    assert_respond_to @document, :dc_subject_sm
    assert_respond_to @document, :b1g_keyword_sm

    # - Temporal
    assert_respond_to @document, :dct_issued_s
    assert_respond_to @document, :dct_temporal_sm
    assert_respond_to @document, :b1g_date_range_drsim
    assert_respond_to @document, :solr_year_i

    # - Spatial
    assert_respond_to @document, :dct_spatial_sm
    assert_respond_to @document, :b1g_geonames_sm
    assert_respond_to @document, :solr_geom
    assert_respond_to @document, :b1g_centroid_ss

    # Distribution
    # - Object
    assert_respond_to @document, :dc_type_sm
    assert_respond_to @document, :layer_geom_type_s
    assert_respond_to @document, :dc_format_s

    # - Access Links
    # - Geospatial Web Services
    # - Images
    # - Metadata
    assert_respond_to @document, :dct_references_s
    assert_respond_to @document, :b1g_image_ss

    # Administrative
    # - Codes
    assert_respond_to @document, :dc_identifier_s
    assert_respond_to @document, :layer_slug_s
    assert_respond_to @document, :dct_provenance_s
    assert_respond_to @document, :b1g_code_s
    assert_respond_to @document, :dct_isPartOf_sm

    # - Status
    assert_respond_to @document, :b1g_status_s
    assert_respond_to @document, :dct_accrualMethod_s
    assert_respond_to @document, :dct_accrualPeriodicity_s
    assert_respond_to @document, :b1g_dateAccessioned_s
    assert_respond_to @document, :b1g_dateRetired_s

    # - Accessibility
    assert_respond_to @document, :dc_rights_s
    assert_respond_to @document, :dct_accessRights_sm
    assert_respond_to @document, :suppressed_b
    assert_respond_to @document, :b1g_child_record_b
  end

  test 'responds to type' do
    assert_respond_to @document, :type
    assert_equal @document.type, 'Document'
  end

  test 'responds to json_attributes' do
    assert_respond_to @document, :json_attributes
  end

  test 'responds to timestamps' do
    assert_respond_to @document, :created_at
    assert_respond_to @document, :updated_at
  end

  test 'responds to friendlier_id' do
    assert_respond_to @document, :friendlier_id
  end

  # Paper Trail
  test 'responds to versions' do
    assert_respond_to @document, :versions
  end

  # To CSV
  test 'responds to to_csv' do
    assert_respond_to @document, :to_csv
  end
end
