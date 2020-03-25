require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  def setup
    @document = Document.new
  end

  test 'responds to title' do
    assert @document.respond_to? :title
  end

  test 'responds to json_attributes' do
    assert @document.respond_to? :json_attributes
  end
end
