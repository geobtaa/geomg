# frozen_string_literal: true

require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  def setup
    @document = Document.new
  end

  test 'responds to title' do
    assert_respond_to @document, :title
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

  test 'responds to versions' do
    assert_respond_to @document, :versions
  end
end
