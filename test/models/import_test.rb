# frozen_string_literal: true

require 'test_helper'

class ImportTest < ActiveSupport::TestCase
  def setup
    @import = Import.new
  end

  test 'responds to import' do
    assert_respond_to @import, :import!
  end
end
