# frozen_string_literal: true

require 'test_helper'

class ImportBtaaTest < ActiveSupport::TestCase
  def setup
    @import = ImportBtaa.new
  end

  # Parent
  test 'responds to import' do
    assert_respond_to @import, :import!
  end

  test 'methods' do
    assert_respond_to @import, :default_mappings
    assert_respond_to @import, :assumed_mappings
    assert_respond_to @import, :derived_mappings
    assert_respond_to @import, :dct_references_mappings
    assert_respond_to @import, :solr_geom_mapping
    assert_respond_to @import, :derive_b1g_centroid_ss
    assert_respond_to @import, :wens_matches
  end
end
