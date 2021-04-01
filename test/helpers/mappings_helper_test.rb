# frozen_string_literal: true

require 'test_helper'

class MappingsHelperTest < ActionView::TestCase

  def setup
    @import = ImportBtaa.new
  end

  test 'attribute_collection' do
    puts attribute_collection.inspect
    attrs = [GEOMG.FIELDS.B1G_CENTROID, GEOMG.FIELDS.B1G_CHILD_RECORD, GEOMG.FIELDS.B1G_CODE, GEOMG.FIELDS.B1G_DATE_ACCESSIONED, GEOMG.FIELDS.B1G_DATE_RETIRED, GEOMG.FIELDS.B1G_DATE_RANGE, GEOMG.FIELDS.B1G_GENRE, GEOMG.FIELDS.B1G_GEONAMES, GEOMG.FIELDS.B1G_IMAGE, GEOMG.FIELDS.B1G_KEYWORD, GEOMG.FIELDS.B1G_STATUS, GEOMG.FIELDS.CREATOR, GEOMG.FIELDS.DESCRIPTION, GEOMG.FIELDS.FORMAT, GEOMG.FIELDS.IDENTIFIER, GEOMG.FIELDS.LANGUAGE, GEOMG.FIELDS.PUBLISHER, GEOMG.FIELDS.RIGHTS, GEOMG.FIELDS.SOURCE, GEOMG.FIELDS.SUBJECT, GEOMG.FIELDS.TITLE, GEOMG.FIELDS.TYPE, GEOMG.FIELDS.ACCESS_RIGHTS, GEOMG.FIELDS.ACCRUAL_METHOD, GEOMG.FIELDS.ACCRUAL_PERIODICITY, GEOMG.FIELDS.ALT_TITLE, GEOMG.FIELDS.IS_PART_OF, GEOMG.FIELDS.ISSUED, GEOMG.FIELDS.PROVENANCE, GEOMG.FIELDS.REFERENCES, GEOMG.FIELDS.SPATIAL, GEOMG.FIELDS.TEMPORAL, GEOMG.FIELDS.LAYER_GEOM_TYPE, GEOMG.FIELDS.LAYER_ID, GEOMG.FIELDS.LAYER_SLUG, GEOMG.FIELDS.GEOM, GEOMG.FIELDS.YEAR, GEOMG.FIELDS.SUPPRESSED].map(&:to_sym)
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
      'dc_language_sm'
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
