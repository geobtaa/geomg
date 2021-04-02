# frozen_string_literal: true

require 'test_helper'

class MappingsHelperTest < ActionView::TestCase

  def setup
    @import = ImportBtaa.new
  end

  test 'attribute_collection' do
    puts attribute_collection.inspect
    attrs = GEOMG.FIELDS.keys.collect{|c| GEOMG.FIELDS.send(c)}.sort
    attrs.prepend('')
    attrs.prepend('Discard')

    assert_equal(
      attribute_collection,
      attrs
    )
  end

  test 'mapping_suggestion - exists' do
    assert_equal(
      mapping_suggestion(@import, 'Language'),
      GEOMG.FIELDS.LANGUAGE
    )
  end

  test 'mapping_suggestion - does not exist' do
    assert_equal(
      mapping_suggestion(@import, 'Does Not Exist'),
      false
    )
  end

  test 'delimiter_suggestion - exists' do
    assert_equal(
      delimiter_suggestion(@import, 'Language'),
      true
    )
  end

  test 'delimiter_suggestion - does not exist' do
    assert_equal(
      delimiter_suggestion(@import, 'Does Not Exist'),
      false
    )
  end
end
