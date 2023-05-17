# frozen_string_literal: true

require "test_helper"

class ImportBtaaTest < ActiveSupport::TestCase
  def setup
    @import = ImportBtaa.new
    @wsen_geom = "-96.6391,40.3754,-90.1401,43.5012"
  end

  # Parent
  test "responds to run" do
    assert_respond_to(@import, :run!)
  end

  test "methods" do
    assert_respond_to(@import, :default_mappings)
    assert_respond_to(@import, :assumed_mappings)
    assert_respond_to(@import, :derived_mappings)
    assert_respond_to(@import, :required_mappings)
    assert_respond_to(@import, :derive_dcat_centroid)
  end

  test "default_mappings" do
    assert_instance_of(Array, @import.default_mappings)
    assert_includes(@import.default_mappings.map(&:keys).flatten, :gbl_mdVersion_s)
  end

  test "derived_mappings" do
    assert_instance_of(Array, @import.derived_mappings)
    assert_includes @import.derived_mappings.map(&:keys).flatten, :dcat_centroid
  end

  test "derive_dcat_centroid" do
    solr_geom_hash = {
      data_hash: {solr_geom: "-18.6,-35.3,52.3,37.17"},
      field: :solr_geom
    }
    assert_instance_of(String, @import.derive_dcat_centroid(solr_geom_hash))
    assert_equal("0.9350000000000023,16.849999999999998", @import.derive_dcat_centroid(solr_geom_hash))
  end

  test "derive_boolean" do
    solr_geom_hash = {
      data_hash: {gbl_suppressed_b: "False"},
      field: :gbl_suppressed_b
    }

    assert_equal(false, @import.derive_boolean(solr_geom_hash))
  end
end
