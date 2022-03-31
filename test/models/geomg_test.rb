# frozen_string_literal: true

require 'test_helper'

class GeomgTest < ActiveSupport::TestCase
  def setup
    @geomg_btaa_csv = Geomg.field_mappings_btaa
  end

  test 'methods' do
    assert_respond_to(Geomg, :field_mappings_btaa)
    assert_respond_to(Geomg, :dct_references_mappings)
    assert_respond_to(Geomg, :iso_language_codes)
  end

  test 'BTAA - CSV Import - header/solr field mapping keys' do
    keys = ['Title', 'Alternative Title', 'Description', 'Language', 'Creator', 'Publisher', 'Provider', 'Resource Class', 'Resource Type', 'Subject', 'ISO Topic Category', 'Keyword', 'Temporal Coverage', 'Date Issued', 'Date Range', 'Spatial Coverage', 'Bounding Box', 'GeoNames', 'Relation', 'Member Of', 'Is Part Of', 'Source', 'Version', 'Replaces', 'Is Replaced By', 'Format', 'File Size', 'WxS Identifier', 'Georeferenced', 'Documentation', 'Download', 'FeatureServer', 'FGDC', 'HTML', 'IIIF', 'ImageServer', 'Information', 'ISO19139', 'Manifest', 'MapServer', 'MODS', 'Index Map', 'TileServer', 'WFS', 'WMS', 'Image', 'ID', 'Identifier', 'Code', 'Rights', 'Rights Holder', 'License', 'Access Rights', 'Accrual Method', 'Accrual Periodicity', 'Date Accessioned', 'Date Retired', 'Status', 'Suppressed', 'Child Record', 'Mediator', 'Access']

    keys.each do |key|
      assert_includes(@geomg_btaa_csv, key.to_sym)
    end
  end

  # @TODO: move to Geomg config test
  test 'dct_references_mappings' do
    assert_instance_of(Hash, Geomg.dct_references_mappings)
    %w[Download FeatureServer ImageServer Information MapServer].each do |mapping|
      assert(Geomg.dct_references_mappings.key?(mapping.to_sym))
    end
  end

  test 'iso_language_codes' do
    assert_instance_of(ActiveSupport::HashWithIndifferentAccess, Geomg.iso_language_codes)
    assert_equal(Geomg.iso_language_codes['fre'], 'French')
  end
end
