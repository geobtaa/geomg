# frozen_string_literal: true

require 'test_helper'

class GeomgTest < ActiveSupport::TestCase
  def setup
    @geomg_btaa_csv = Geomg.field_mappings_btaa
  end

  test 'btaa field mapping keys' do
    keys = ['Title', 'Alternative Title', 'Description', 'Language', 'Publisher', 'Creator', 'Genre', 'Subject', 'Keyword', 'Date Issued', 'Temporal Coverage', 'Date Range', 'Solr Year', 'Spatial Coverage', 'Bounding Box', 'Format', 'Type', 'Geometry Type', 'Information', 'Download', 'FeatureServer', 'MapServer', 'ImageServer', 'Image', 'Identifier', 'Provenance', 'Code', 'Is Part Of', 'Status', 'Accrual Method', 'Date Accessioned', 'Rights', 'Suppressed', 'Child']

    keys.each do |key|
      assert_includes(@geomg_btaa_csv, key.to_sym)
    end
  end
end
