# frozen_string_literal: true

require 'test_helper'

class DocumentStateMachineTest < ActiveSupport::TestCase
  test 'states' do
    assert_equal(DocumentStateMachine.states, %w[Draft Published Unpublished])
  end
end
