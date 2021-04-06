# frozen_string_literal: true

require 'test_helper'

class GeomgTest < ActiveSupport::TestCase
  def setup
    @geomg_btaa_csv = Geomg.field_mappings_btaa
  end

  test 'methods' do
    assert_respond_to(Geomg, :field_mappings_btaa)
    assert_respond_to(Geomg, :dct_references_mappings)
  end

  test 'BTAA - CSV Import - header/solr field mapping keys' do
    keys = ['Title', 'Alternative Title', 'Description', 'Language', 'Publisher', 'Creator', 'Genre', 'Subject', 'Keyword', 'Date Issued', 'Temporal Coverage', 'Date Range', 'Spatial Coverage', 'Bounding Box', 'Format', 'Geometry Type', 'Information', 'Download', 'FeatureServer', 'MapServer', 'ImageServer', 'Image', 'Identifier', 'Provenance', 'Code', 'Is Part Of', 'Status', 'Accrual Method', 'Accrual Periodicity', 'Date Accessioned', 'Rights', 'Suppressed', 'Child']

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
end
