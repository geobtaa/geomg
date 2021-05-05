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
    assert_equal output_hash['gbl_mdVersion_s'], ['Aardvark']

    # Form
    # Identification
    # - Descriptive
    assert_equal output_hash[Settings.FIELDS.TITLE], ['Agricultural Districts: Iowa']
    assert_equal output_hash[Settings.FIELDS.ALT_TITLE], ['Ag Districts']
    assert_equal output_hash[Settings.FIELDS.DESCRIPTION], ['Iowa Agricultural Districts']
    assert_equal output_hash[Settings.FIELDS.LANGUAGE], ['English']

    # - Credits
    assert_equal output_hash[Settings.FIELDS.CREATOR], ['Legislative Services Agency']
    assert_equal output_hash[Settings.FIELDS.PUBLISHER], ['State of Iowa']

    # - Categories
    assert_equal output_hash[Settings.FIELDS.B1G_GENRE], ['Datasets']
    assert_equal output_hash[Settings.FIELDS.SUBJECT], ['Boundaries']
    assert_equal output_hash[Settings.FIELDS.B1G_KEYWORD], %w[iowa judicial districts boundaries]

    # - Temporal
    assert_equal output_hash[Settings.FIELDS.ISSUED], ['2015-09-03']
    assert_equal output_hash[Settings.FIELDS.TEMPORAL], ['2015']
    assert_equal output_hash[Settings.FIELDS.B1G_DATE_RANGE], ['[2015 TO 2015]']
    assert_equal output_hash[Settings.FIELDS.YEAR], ['2015']

    # - Spatial
    assert_equal output_hash[Settings.FIELDS.SPATIAL], ['Iowa']
    assert_nil output_hash[Settings.FIELDS.B1G_GEONAMES]
    assert_equal output_hash[Settings.FIELDS.GEOM], ['ENVELOPE(-96.6391,-90.1401,43.5012,40.3754)']
    assert_equal output_hash[Settings.FIELDS.B1G_CENTROID], ['41.9383,-93.3896']

    # Distribution
    # - Object
    assert_equal output_hash[Settings.FIELDS.LAYER_GEOM_TYPE], ['Vector']
    assert_equal output_hash[Settings.FIELDS.FORMAT], ['Shapefile']

    # - Access Links
    # - Geospatial Web Services
    # - Images
    # - Metadata

    # @TODO: assert stringified JSON
    # assert_equal output_hash['dct_references_s'], ['{\"http://schema.org/url\":\"https://lib.msu.edu/branches/map/AfJPEGs/494a-b_ae55e6v2_l/\",\"http://schema.org/downloadUrl\":\"https://archive.lib.msu.edu/maps/MSU-Scanned/Africa/494a-b_ae55e6v2_l.jpg\"}']

    assert_nil output_hash[Settings.FIELDS.B1G_IMAGE]

    # Administrative
    # - Codes
    assert_equal output_hash[Settings.FIELDS.IDENTIFIER], ['35c8a641589c4e13b7aa11e37f3f00a1_0']
    assert_equal output_hash[Settings.FIELDS.LAYER_SLUG], ['35c8a641589c4e13b7aa11e37f3f00a1_0']
    assert_equal output_hash[Settings.FIELDS.PROVENANCE], ['Iowa']
    assert_equal output_hash[Settings.FIELDS.B1G_CODE], ['03a-04']
    # assert_equal output_hash[Settings.FIELDS.IS_PART_OF], ['03a-04']

    # - Status
    assert_equal output_hash[Settings.FIELDS.B1G_STATUS], ['Active']
    assert_equal output_hash[Settings.FIELDS.B1G_ACCRUAL_METHOD], ['ArcGIS Hub']
    assert_nil output_hash[Settings.FIELDS.ACCRUAL_PERIODICITY]
    assert_equal output_hash[Settings.FIELDS.B1G_DATE_ACCESSIONED], ['2020-04-24']
    assert_nil output_hash[Settings.FIELDS.B1G_DATE_RETIRED]
    assert_equal output_hash['b1g_publication_state_s'], ['draft']

    # - Accessibility
    assert_equal output_hash[Settings.FIELDS.ACCESS_RIGHTS], ['Public']
    assert_equal output_hash[Settings.FIELDS.SUPPRESSED], [false]
    assert_equal output_hash[Settings.FIELDS.B1G_CHILD_RECORD], [false]
  end
end
