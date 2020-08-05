# frozen_string_literal: true

require 'test_helper'

class DocumentIndexerTest < ActiveSupport::TestCase
  setup do
    @document = documents(:africa)
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
    assert_equal output_hash['dc_title_s'], ['Физическая Карта Африки [Physical Map of Africa]']
    assert_nil output_hash['dct_alternativeTitle_sm']
    assert_equal output_hash['dc_description_s'], ['In Entsiklopedicheskii Slovar, pod redaktsiei professora I. F. Andreevskago. Tom I-XLIA ... Izdateli: F. A. Brokgauz (Leiptsig) I. A. Efron. St. Peterburg. 1890-1904.']
    assert_equal output_hash['dc_language_sm'], ['English']

    # - Credits
    assert_nil output_hash['dc_creator_sm']
    assert_nil output_hash['dc_publisher_sm']

    # - Categories
    assert_equal output_hash['b1g_genre_sm'], ['Maps']
    assert_nil output_hash['dc_subject_sm']
    assert_equal output_hash['b1g_keyword_sm'], ['Michigan State University Map Library']

    # - Temporal
    assert_nil output_hash['dct_issued_s']
    assert_equal output_hash['dct_temporal_sm'], ['1890-1904']
    assert_equal output_hash['b1g_date_range_drsim'], ['[1890 TO 1890]']
    assert_equal output_hash['solr_year_i'], ['1890']

    # - Spatial
    assert_equal output_hash['dct_spatial_sm'], ['Africa']
    assert_nil output_hash['b1g_geonames_sm']
    assert_equal output_hash['solr_geom'], ['ENVELOPE(-18.6,52.3,37.17,-35.3)']
    assert_equal output_hash['b1g_centroid_ss'], ['0.9350000000000023,16.849999999999998']

    # Distribution
    # - Object
    assert_equal output_hash['dc_type_sm'], ['Image']
    assert_equal output_hash['layer_geom_type_s'], ['Image']
    assert_equal output_hash['dc_format_s'], ['JPEG']

    # - Access Links
    # - Geospatial Web Services
    # - Images
    # - Metadata

    # @TODO: assert stringified JSON
    # assert_equal output_hash['dct_references_s'], ['{\"http://schema.org/url\":\"https://lib.msu.edu/branches/map/AfJPEGs/494a-b_ae55e6v2_l/\",\"http://schema.org/downloadUrl\":\"https://archive.lib.msu.edu/maps/MSU-Scanned/Africa/494a-b_ae55e6v2_l.jpg\"}']

    assert_equal output_hash['b1g_image_ss'], ['https://btaagdp.org/maps/files/original/9d1dcfad589f83b7b3b3997586fb8210.jpg']

    # Administrative
    # - Codes
    assert_equal output_hash['dc_identifier_s'], ['06e7f566-852a-4914-929d-1bef38132eba']
    assert_equal output_hash['layer_slug_s'], ['06e7f566-852a-4914-929d-1bef38132eba']
    assert_equal output_hash['dct_provenance_s'], ['Michigan State']
    assert_equal output_hash['b1g_code_s'], ['06d-01']
    assert_equal output_hash['dct_isPartOf_sm'], ['06d-01']

    # - Status
    assert_equal output_hash['b1g_status_s'], ['Active']
    assert_nil output_hash['dct_accrualMethod_s']
    assert_nil output_hash['dct_accrualPeriodicity_s']
    assert_equal output_hash['b1g_dateAccessioned_s'], ['2019-01-16']
    assert_nil output_hash['b1g_dateRetired_s']

    # - Accessibility
    assert_equal output_hash['dc_rights_s'], ['Public']
    assert_nil output_hash['dct_accessRights_sm']
    assert_equal output_hash['suppressed_b'], [false]
    assert_nil output_hash['b1g_child_record_b']
  end
end
