# frozen_string_literal: true

require 'test_helper'

class Document::ControlledListsTest < ActiveSupport::TestCase
  test 'lists are present' do
    assert_not_empty(Document::ControlledLists::ACCRUAL_PERIODICITY)
    assert_not_empty(Document::ControlledLists::B1G_STATUS)
    assert_not_empty(Document::ControlledLists::FORMATS)
    assert_not_empty(Document::ControlledLists::GENRE)
    assert_not_empty(Document::ControlledLists::LAYER_GEOM_TYPES)
    assert_not_empty(Document::ControlledLists::RIGHTS)
    assert_not_empty(Document::ControlledLists::TYPE)
  end
end
