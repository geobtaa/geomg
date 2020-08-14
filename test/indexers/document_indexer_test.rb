# frozen_string_literal: true

require 'test_helper'

class DocumentIndexerTest < ActiveSupport::TestCase
  setup do
    @document = documents(:ag)
  end

  test 'indexes' do
    output_hash = DocumentIndexer.new.map_record(@document)

    assert(output_hash).present?
    # Kithe
    assert_equal output_hash['model_pk_ssi'], [@document.id]

    # GeoBlacklight
    assert_equal output_hash['geoblacklight_version'], ['1.0']

    # Form
    # Identification
    # - Descriptive
    assert_equal output_hash['dc_title_s'], ['Agricultural Districts: Iowa']
    assert_equal output_hash['dct_alternativeTitle_sm'], ['Ag Districts']
    assert_equal output_hash['dc_description_s'], ['Iowa Agricultural Districts']
    assert_equal output_hash['dc_language_sm'], ['English']

    # - Credits
    assert_equal output_hash['dc_creator_sm'], ['Legislative Services Agency']
    assert_equal output_hash['dc_publisher_sm'], ['State of Iowa']

    # - Categories
    assert_equal output_hash['b1g_genre_sm'], ['Geospatial data']
    assert_equal output_hash['dc_subject_sm'], ['Boundaries']
    assert_equal output_hash['b1g_keyword_sm'], %w[iowa judicial districts boundaries]

    # - Temporal
    assert_equal output_hash['dct_issued_s'], ['2015-09-03']
    assert_equal output_hash['dct_temporal_sm'], ['2015']
    assert_equal output_hash['b1g_date_range_drsim'], ['[2015 TO 2015]']
    assert_equal output_hash['solr_year_i'], ['2015']

    # - Spatial
    assert_equal output_hash['dct_spatial_sm'], ['Iowa']
    assert_nil output_hash['b1g_geonames_sm']
    assert_equal output_hash['solr_geom'], ['ENVELOPE(-96.6391,-90.1401,43.5012,40.3754)']
    assert_equal output_hash['b1g_centroid_ss'], ['41.9383,-93.3896']

    # Distribution
    # - Object
    assert_equal output_hash['dc_type_sm'], %w[Dataset Service]
    assert_equal output_hash['layer_geom_type_s'], ['Vector']
    assert_equal output_hash['dc_format_s'], ['Shapefile']

    # - Access Links
    # - Geospatial Web Services
    # - Images
    # - Metadata

    # @TODO: assert stringified JSON
    # assert_equal output_hash['dct_references_s'], ['{\"http://schema.org/url\":\"https://lib.msu.edu/branches/map/AfJPEGs/494a-b_ae55e6v2_l/\",\"http://schema.org/downloadUrl\":\"https://archive.lib.msu.edu/maps/MSU-Scanned/Africa/494a-b_ae55e6v2_l.jpg\"}']

    assert_nil output_hash['b1g_image_ss']

    # Administrative
    # - Codes
    assert_equal output_hash['dc_identifier_s'], ['35c8a641589c4e13b7aa11e37f3f00a1_0']
    assert_equal output_hash['layer_slug_s'], ['35c8a641589c4e13b7aa11e37f3f00a1_0']
    assert_equal output_hash['dct_provenance_s'], ['Iowa']
    assert_equal output_hash['b1g_code_s'], ['03a-04']
    assert_equal output_hash['dct_isPartOf_sm'], ['03a-04']

    # - Status
    assert_equal output_hash['b1g_status_s'], ['Active']
    assert_equal output_hash['dct_accrualMethod_s'], ['ArcGIS Hub']
    assert_nil output_hash['dct_accrualPeriodicity_s']
    assert_equal output_hash['b1g_dateAccessioned_s'], ['2020-04-24']
    assert_nil output_hash['b1g_dateRetired_s']
    assert_equal output_hash['b1g_publication_state_s'], ['Draft']

    # - Accessibility
    assert_equal output_hash['dc_rights_s'], ['Public']
    assert_nil output_hash['dct_accessRights_sm']
    assert_equal output_hash['suppressed_b'], [false]
    assert_equal output_hash['b1g_child_record_b'], [false]
  end
end
