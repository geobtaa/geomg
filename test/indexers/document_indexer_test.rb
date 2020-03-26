require 'test_helper'

class DocumentIndexerTest < ActiveSupport::TestCase
  setup do
    @document = documents(:africa)
  end

  test 'indexes' do
    output_hash = DocumentIndexer.new.map_record(@document)

    assert(output_hash).present?
    assert_equal output_hash["model_pk_ssi"], [@document.id]
  end
end
