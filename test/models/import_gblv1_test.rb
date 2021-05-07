# frozen_string_literal: true

require 'test_helper'

class ImportGblv1Test < ActiveSupport::TestCase
  def setup
    @import = ImportGblv1.new
    @solr_geom = 'ENVELOPE(-123.387366, -122.52958, 39.398403, 38.302994)'
    @dct_references_example = [{:category=>nil, :value=>"{\"http://schema.org/downloadUrl\":\"https://conservancy.umn.edu/bitstream/handle/11299/211408/12580_auto_accessibility_data_2018_geopackage.zip\",\"http://lccn.loc.gov/sh85035852\":\"https://conservancy.umn.edu/bitstream/handle/11299/211408/2018DataDoc_all_LEHD.pdf\",\"http://schema.org/url\":\"http://hdl.handle.net/11299/211408\"}"}]
  end

  # Parent
  test 'responds to run' do
    assert_respond_to(@import, :run!)
  end

  test 'methods' do
    assert_respond_to(@import, :default_mappings)
    assert_respond_to(@import, :assumed_mappings)
    assert_respond_to(@import, :derived_mappings)
    assert_respond_to(@import, :required_mappings)
    assert_respond_to(@import, :solr_geom_mapping)
    assert_respond_to(@import, :geomg_b1g_date_range_drsim)
    assert_respond_to(@import, :geomg_dct_references_s)
  end

  test 'default_mappings' do
    assert_instance_of(Array, @import.default_mappings)
    assert_includes(@import.default_mappings.map(&:keys).flatten, :geoblacklight_version)
  end

  test 'derived_mappings' do
    assert_instance_of(Array, @import.derived_mappings)
    assert_includes @import.derived_mappings.map(&:keys).flatten, :dct_references_s
    assert_includes @import.derived_mappings.map(&:keys).flatten, :b1g_date_range_drsim
  end

  test 'required_mappings' do
    assert_instance_of(Array, @import.required_mappings)
    assert_includes @import.required_mappings.map(&:keys).flatten, :b1g_status_s
  end

  test 'solr_geom_mapping' do
    # "Remove any CSV \\ escape chars"
    geom_escaped = @import.solr_geom_mapping(@solr_geom)
    assert_instance_of(String, geom_escaped)
    assert_match(/ENVELOPE/, geom_escaped)
  end

  test 'geomg_dct_references_s' do
    dct_references_hash = {
      data_hash: { dct_references_s: @dct_references_example },
      field: :dct_references_s
    }

    references = @import.geomg_dct_references_s(dct_references_hash)

    assert_instance_of(Array, references)
    assert_includes references.collect{ |c| c[:category] }, "download"
  end
end
