# frozen_string_literal: true

require "test_helper"

class DocumentTest < ActiveSupport::TestCase
  def setup
    @document = Document.new
  end

  # Create / db-stored title should also be dct_title_s
  test "creates a document" do
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
  test "responds to title" do
    assert_respond_to @document, :title
  end

  test "responds to publication_state" do
    assert_respond_to @document, :publication_state
    assert_respond_to @document, :current_state
  end

  test "responds to import" do
    assert_respond_to @document, :import
  end

  test "kithe_indexable_mapper" do
    assert_respond_to @document, :kithe_indexable_mapper
  end

  test "responds to B1G attributes" do
    # Form
    # Identification
    # - Descriptive
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:title]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:alternative_title]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:description]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:language]

    # - Credits
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:creator]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:creator_id]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:publisher]

    # - Categories
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:resource_class]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:subject]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:keyword]

    # - Temporal
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:date_issued]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:temporal_coverage]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:date_range]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:index_year]

    # - Spatial
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:spatial_coverage]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:geonames]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:bounding_box]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:centroid]

    # Distribution
    # - Object
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:resource_type]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:format]

    # - Access Links
    # - Geospatial Web Services
    # - Images
    # - Metadata
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:reference]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:b1g_image_url]

    # Administrative
    # - Codes
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:identifier]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:id]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:provider]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:code]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:is_part_of]

    # - Status
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:status]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:accrual_method]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:accrual_periodicity]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:date_accessioned]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:date_retired]

    # - Accessibility
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:rights]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:access_rights]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:suppressed_record]
    assert_respond_to @document, Geomg::Schema.instance.solr_fields[:child_record]
  end

  test "responds to type" do
    assert_respond_to @document, :type
    assert_equal @document.type, "Document"
  end

  test "responds to json_attributes" do
    assert_respond_to @document, :json_attributes
  end

  test "responds to timestamps" do
    assert_respond_to @document, :created_at
    assert_respond_to @document, :updated_at
  end

  test "responds to friendlier_id" do
    assert_respond_to @document, :friendlier_id
  end

  test "responds to iso_language_mapping" do
    assert_respond_to @document, :iso_language_mapping
    @document = documents(:ag)
    assert_equal(@document.iso_language_mapping, ["English"])
  end

  # Paper Trail
  test "responds to versions" do
    assert_respond_to @document, :versions
  end

  # To CSV
  test "responds to to_csv" do
    assert_respond_to @document, :to_csv
  end

  # Test DateRanges
  test "b1g_date_range validation" do
    # YYYY-YYYY is valid
    @document = documents(:ag)
    @document.send("#{Geomg::Schema.instance.solr_fields[:date_range]}=", ["1977-2020"])
    assert_nothing_raised do
      @document.save
    end

    # YYYY-* or *-YYYY is valid
    @document.send("#{Geomg::Schema.instance.solr_fields[:date_range]}=", ["YYYY-*"])
    assert_nothing_raised do
      @document.save
    end
    @document.send("#{Geomg::Schema.instance.solr_fields[:date_range]}=", ["*-YYYY"])
    assert_nothing_raised do
      @document.save
    end

    # Start YYYY == End YYYY is valid
    @document.send("#{Geomg::Schema.instance.solr_fields[:date_range]}=", ["1851-1851"])
    assert_nothing_raised do
      @document.save
    end

    # No empty side allowed
    @document.send("#{Geomg::Schema.instance.solr_fields[:date_range]}=", ["1977-"])
    @document.save
    assert @document.invalid?
    assert @document.errors

    # No letters allowed
    @document.send("#{Geomg::Schema.instance.solr_fields[:date_range]}=", ["197X-2020"])
    @document.save
    assert @document.invalid?
    assert @document.errors

    # No trailing punctuation allowed
    @document.send("#{Geomg::Schema.instance.solr_fields[:date_range]}=", ["1851-1851?"])
    @document.save
    assert @document.invalid?
    assert @document.errors

    # Accepts only 1 wildcard
    @document.send("#{Geomg::Schema.instance.solr_fields[:date_range]}=", ["*-*"])
    @document.save
    assert @document.invalid?
    assert @document.errors

    # Start date must be lower than End date
    @document.send("#{Geomg::Schema.instance.solr_fields[:date_range]}=", ["1996-1977"])
    @document.save
    assert @document.invalid?
    assert @document.errors
  end

  # Test Bbox
  test "bbox validation" do
    @document = documents(:ag)

    # Bad minY
    @document.send("#{Geomg::Schema.instance.solr_fields[:bounding_box]}=", "-16.7909,-90.0574,43.9474,39.9655")
    assert @document.invalid?
    assert @document.errors

    # No ENVELOPE() wrapper allowed
    @document.send("#{Geomg::Schema.instance.solr_fields[:bounding_box]}=", "ENVELOPE(-16.7909,-90.0574,43.9474,39.9655)")
    @document.save
    assert @document.invalid?
    assert @document.errors

    # Bad minX
    @document.send("#{Geomg::Schema.instance.solr_fields[:bounding_box]}=", "-16000.7909,-90.0574,43.9474,39.9655")
    @document.save
    assert @document.invalid?
    assert @document.errors

    # Solr - maxY must be >= minY
    @document.send("#{Geomg::Schema.instance.solr_fields[:bounding_box]}=", "92.1893,28.5432,101.1768,9.6004")
    @document.save
    assert @document.invalid?
    assert @document.errors

    # Solr - maxY must be >= minY - https://github.com/geobtaa/geomg/issues/173
    @document.send("#{Geomg::Schema.instance.solr_fields[:bounding_box]}=", "-97.25,-89.5,49.3833,433.0")
    @document.save
    assert @document.invalid?
    assert @document.errors

    # Solr - invalid minY - https://github.com/geobtaa/geomg/issues/173
    @document.send("#{Geomg::Schema.instance.solr_fields[:bounding_box]}=", "-113.5667,-512.6667,78.5833,6.4333")
    @document.save
    assert @document.invalid?
    assert @document.errors

    # Solr - invalid decimals - https://github.com/geobtaa/geomg/issues/173
    @document.send("#{Geomg::Schema.instance.solr_fields[:bounding_box]}=", "-118.00.0000,-88.00.0000,51.00.0000,42.00.0000")
    @document.save
    assert @document.invalid?
    assert @document.errors
  end

  # Test solr_year_json
  test "derive gbl_indexYear_im via gbl_dateRange_drsim" do
    @document = documents(:ag)
    # Input date range
    # "gbl_dateRange_drsim": ["2015-2015"]

    # Export indexYear values
    # Via method and via alias
    assert_equal(@document.solr_year_json, ["2015"])
    assert_equal(@document.gbl_indexYear_im, ["2015"])
  end
end
