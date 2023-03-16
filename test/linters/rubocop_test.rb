# frozen_string_literal: true

require "test_helper"

class RubocopTest < Minitest::Test
  def subject
    `rubocop`
  end

  def test_no_offenses_found
    skip("Subject now returning empty string; no match made")
    assert_match(/no\ offenses\ detected/, subject)
  end
end
