require "test_helper"

class ElementTest < ActiveSupport::TestCase
  def setup
    @element = Element.new
  end

  # Attrs
  test 'responds to list' do
    assert_respond_to Element, :list
  end

  test 'responds to method_missing' do
    skip('Override Element.respond_to?')
    assert_kind_of Element.title, Element
  end
end
