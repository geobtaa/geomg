# frozen_string_literal: true

require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  def setup
    @document = Document.new
  end

  # Create / db-stored title should also be dct_title_s
  test 'creates a document' do
    @document.title = "Test"
    @document.dct_accessRights_s = "Public"
    @document.gbl_resourceClass_sm = "Collections"
    @document.geomg_id_s = "eric-test-foo"

    assert_nothing_raised do
      @document.save
    end

    assert_equal(@document.title, @document.dct_title_s)
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
    assert_respond_to @document, GEOMG.FIELDS.TITLE
    assert_respond_to @document, GEOMG.FIELDS.ALT_TITLE
    assert_respond_to @document, GEOMG.FIELDS.DESCRIPTION
    assert_respond_to @document, GEOMG.FIELDS.LANGUAGE

    # - Credits
    assert_respond_to @document, GEOMG.FIELDS.CREATOR
    assert_respond_to @document, GEOMG.FIELDS.PUBLISHER

    # - Categories
    assert_respond_to @document, GEOMG.FIELDS.B1G_GENRE
    assert_respond_to @document, GEOMG.FIELDS.SUBJECT
    assert_respond_to @document, GEOMG.FIELDS.B1G_KEYWORD

    # - Temporal
    assert_respond_to @document, GEOMG.FIELDS.ISSUED
    assert_respond_to @document, GEOMG.FIELDS.TEMPORAL
    assert_respond_to @document, GEOMG.FIELDS.B1G_DATE_RANGE
    assert_respond_to @document, GEOMG.FIELDS.YEAR

    # - Spatial
    assert_respond_to @document, GEOMG.FIELDS.SPATIAL
    assert_respond_to @document, GEOMG.FIELDS.B1G_GEONAMES
    assert_respond_to @document, GEOMG.FIELDS.BBOX
    assert_respond_to @document, GEOMG.FIELDS.B1G_CENTROID

    # Distribution
    # - Object
    assert_respond_to @document, GEOMG.FIELDS.LAYER_GEOM_TYPE
    assert_respond_to @document, GEOMG.FIELDS.FORMAT

    # - Access Links
    # - Geospatial Web Services
    # - Images
    # - Metadata
    assert_respond_to @document, GEOMG.FIELDS.REFERENCES
    assert_respond_to @document, GEOMG.FIELDS.B1G_IMAGE

    # Administrative
    # - Codes
    assert_respond_to @document, GEOMG.FIELDS.IDENTIFIER
    assert_respond_to @document, GEOMG.FIELDS.LAYER_SLUG
    assert_respond_to @document, GEOMG.FIELDS.PROVENANCE
    assert_respond_to @document, GEOMG.FIELDS.B1G_CODE
    assert_respond_to @document, GEOMG.FIELDS.IS_PART_OF

    # - Status
    assert_respond_to @document, GEOMG.FIELDS.B1G_STATUS
    assert_respond_to @document, GEOMG.FIELDS.B1G_ACCRUAL_METHOD
    assert_respond_to @document, GEOMG.FIELDS.B1G_ACCRUAL_PERIODICITY
    assert_respond_to @document, GEOMG.FIELDS.B1G_DATE_ACCESSIONED
    assert_respond_to @document, GEOMG.FIELDS.B1G_DATE_RETIRED

    # - Accessibility
    assert_respond_to @document, GEOMG.FIELDS.RIGHTS
    assert_respond_to @document, GEOMG.FIELDS.ACCESS_RIGHTS
    assert_respond_to @document, GEOMG.FIELDS.SUPPRESSED
    assert_respond_to @document, GEOMG.FIELDS.B1G_CHILD_RECORD
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

  test 'responds to iso_language_mapping' do
    assert_respond_to @document, :iso_language_mapping
    @document = documents(:ag)
    assert_equal(@document.iso_language_mapping, ["English"])
  end

  # Paper Trail
  test 'responds to versions' do
    assert_respond_to @document, :versions
  end

  # To CSV
  test 'responds to to_csv' do
    assert_respond_to @document, :to_csv
  end

  # Test DateRanges
  test 'b1g_date_range validation' do
    # YYYY-YYYY is valid
    @document = documents(:ag)
    @document.send("#{GEOMG.FIELDS.B1G_DATE_RANGE}=",["1977-2020"])
    assert_nothing_raised do
      @document.save
    end

    # YYYY-* or *-YYYY is valid
    @document.send("#{GEOMG.FIELDS.B1G_DATE_RANGE}=",["YYYY-*"])
    assert_nothing_raised do
      @document.save
    end
    @document.send("#{GEOMG.FIELDS.B1G_DATE_RANGE}=",["*-YYYY"])
    assert_nothing_raised do
      @document.save
    end

    # Start YYYY == End YYYY is valid
    @document.send("#{GEOMG.FIELDS.B1G_DATE_RANGE}=",["1851-1851"])
    assert_nothing_raised do
      @document.save
    end

    # No empty side allowed
    @document.send("#{GEOMG.FIELDS.B1G_DATE_RANGE}=", ["1977-"])
    @document.save
    assert @document.invalid?
    assert @document.errors

    # No letters allowed
    @document.send("#{GEOMG.FIELDS.B1G_DATE_RANGE}=", ["197X-2020"])
    @document.save
    assert @document.invalid?
    assert @document.errors

    # No trailing punctuation allowed
    @document.send("#{GEOMG.FIELDS.B1G_DATE_RANGE}=", ["1851-1851?"])
    @document.save
    assert @document.invalid?
    assert @document.errors

    # Accepts only 1 wildcard
    @document.send("#{GEOMG.FIELDS.B1G_DATE_RANGE}=", ["*-*"])
    @document.save
    assert @document.invalid?
    assert @document.errors

    # Start date must be lower than End date
    @document.send("#{GEOMG.FIELDS.B1G_DATE_RANGE}=", ["1996-1977"])
    @document.save
    assert @document.invalid?
    assert @document.errors
  end

  # Test Bbox
  test 'bbox validation' do
    @document = documents(:ag)

    # Bad minY
    @document.send("#{GEOMG.FIELDS.BBOX}=", "-16.7909,-90.0574,43.9474,39.9655")
    assert @document.invalid?
    assert @document.errors

    # No ENVELOPE() wrapper allowed
    @document.send("#{GEOMG.FIELDS.BBOX}=", "ENVELOPE(-16.7909,-90.0574,43.9474,39.9655)")
    @document.save
    assert @document.invalid?
    assert @document.errors

    # Bad minX
    @document.send("#{GEOMG.FIELDS.BBOX}=", "-16000.7909,-90.0574,43.9474,39.9655")
    @document.save
    assert @document.invalid?
    assert @document.errors

    # Solr - maxY must be >= minY
    @document.send("#{GEOMG.FIELDS.BBOX}=", "92.1893,28.5432,101.1768,9.6004")
    @document.save
    assert @document.invalid?
    assert @document.errors

    # Solr - maxY must be >= minY - https://github.com/geobtaa/geomg/issues/173
    @document.send("#{GEOMG.FIELDS.BBOX}=", "-97.25,-89.5,49.3833,433.0")
    @document.save
    assert @document.invalid?
    assert @document.errors

    # Solr - invalid minY - https://github.com/geobtaa/geomg/issues/173
    @document.send("#{GEOMG.FIELDS.BBOX}=", "-113.5667,-512.6667,78.5833,6.4333")
    @document.save
    assert @document.invalid?
    assert @document.errors

    # Solr - invalid decimals - https://github.com/geobtaa/geomg/issues/173
    @document.send("#{GEOMG.FIELDS.BBOX}=", "-118.00.0000,-88.00.0000,51.00.0000,42.00.0000")
    @document.save
    assert @document.invalid?
    assert @document.errors
  end

  # Test solr_year_json
  test 'derive gbl_indexYear_im via gbl_dateRange_drsim' do
    @document = documents(:ag)
    # Input date range
    # "gbl_dateRange_drsim": ["2015-2015"]

    # Export indexYear values
    # Via method and via alias
    assert_equal(@document.solr_year_json, ["2015"])
    assert_equal(@document.gbl_indexYear_im, ["2015"])
  end
end
