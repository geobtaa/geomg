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
    assert_respond_to @document, GEOMG.FIELDS.GEOM
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
    @document = documents(:ag)
    @document.send("#{GEOMG.FIELDS.B1G_DATE_RANGE}=",["1977-2020"])
    assert_nothing_raised do
      @document.save
    end

    # No letters allowed
    @document.send("#{GEOMG.FIELDS.B1G_DATE_RANGE}=", ["197X-2020"])
    @document.save
    assert @document.invalid?
    assert @document.errors
  end

  # Test SolrGeom
  test 'solr_geom validation' do
    @document = documents(:ag)
    @document.send("#{GEOMG.FIELDS.GEOM}=", "ENVELOPE(-16.7909,-90.0574,43.9474,39.9655)")
    assert_nothing_raised do
      @document.save
    end

    # No ENVELOPE() wrapper
    @document.send("#{GEOMG.FIELDS.GEOM}=", "-16.7909,-90.0574,43.9474,39.9655")
    @document.save
    assert @document.invalid?
    assert @document.errors

    # Bad minX
    @document.send("#{GEOMG.FIELDS.GEOM}=", "-16000.7909,-90.0574,43.9474,39.9655")
    @document.save
    assert @document.invalid?
    assert @document.errors
  end
end
