# frozen_string_literal: true

require 'test_helper'

class ImportBtaaTest < ActiveSupport::TestCase
  def setup
    @import = ImportBtaa.new
    @wsen_geom = '-96.6391,40.3754,-90.1401,43.5012'
  end

  # Parent
  test 'responds to import' do
    assert_respond_to(@import, :import!)
  end

  test 'methods' do
    assert_respond_to(@import, :default_mappings)
    assert_respond_to(@import, :assumed_mappings)
    assert_respond_to(@import, :derived_mappings)
    assert_respond_to(@import, :solr_geom_mapping)
    assert_respond_to(@import, :derive_b1g_centroid_ss)
    assert_respond_to(@import, :wens_matches)
  end

  test 'default_mappings' do
    assert_instance_of(Array, @import.default_mappings)
    assert_includes(@import.default_mappings.map(&:keys).flatten, :geoblacklight_version)
  end

  test 'derived_mappings' do
    assert_instance_of(Array, @import.derived_mappings)
    assert_includes @import.derived_mappings.map(&:keys).flatten, :b1g_centroid_ss
  end

  test 'solr_geom_mapping' do
    # "W,S,E,N" convert to "ENVELOPE(W,E,N,S)"
    geom_mapped = @import.solr_geom_mapping(@wsen_geom)
    assert_instance_of(String, geom_mapped)
    assert_match(/ENVELOPE/, geom_mapped)
  end

  test 'wens_matches' do
    # "W,S,E,N" convert to "ENVELOPE(W,E,N,S)"
    geom_mapped = @import.solr_geom_mapping(@wsen_geom)
    matches = @import.wens_matches(geom_mapped)
    assert_instance_of(Array, matches)
    assert_equal @wsen_geom.split(',')[1], matches[3]
  end

  test 'derive_b1g_centroid_ss' do
    solr_geom_hash = {
      data_hash: { solr_geom: 'ENVELOPE(-18.6,52.3,37.17,-35.3)' },
      field: :solr_geom
    }
    assert_instance_of(String, @import.derive_b1g_centroid_ss(solr_geom_hash))
    assert_equal('0.9350000000000023,16.849999999999998', @import.derive_b1g_centroid_ss(solr_geom_hash))
  end
end
