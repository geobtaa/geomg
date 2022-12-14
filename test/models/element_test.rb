require "test_helper"

class ElementTest < ActiveSupport::TestCase
  def setup
    @element = Element.new
  end

  # Attrs
  test 'responds to list' do
    assert_respond_to Element, :list
  end

  test 'list' do
    assert_equal Element.list, [:title]
  end

  test 'export_value' do
    @element = elements(:one)
    assert_equal @element.export_value, 'dct_title_s'
  end

  test 'self.label_nocase' do
    @element = elements(:one)
    assert_equal Element.send(:label_nocase, 'title'), @element
  end

  test 'self.at' do
    @element = elements(:one)
    assert_equal Element.send(:at, 'dct_title_s'), @element
  end

  test 'success - responds to method_missing' do
    assert_kind_of Element, Element.title
  end

  test 'fail - responds to method_missing' do
    assert_raise NoMethodError do
      Element.foo
    end
  end

end
