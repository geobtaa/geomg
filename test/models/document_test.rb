require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  def setup
    @document = Document.new
  end

  test 'responds to title' do
    assert @document.respond_to? :title
  end

  test 'responds to type' do
    assert @document.respond_to? :type
    assert_equal @document.type, 'Document'
  end

  test 'responds to json_attributes' do
    assert @document.respond_to? :json_attributes
  end

  test 'responds to timestamps' do
    assert @document.respond_to? :created_at
    assert @document.respond_to? :updated_at
  end

  test 'responds to friendlier_id' do
    assert @document.respond_to? :friendlier_id
  end
end
