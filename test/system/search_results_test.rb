# frozen_string_literal: true

require 'application_system_test_case'

class SearchResultsTest < ApplicationSystemTestCase
  def setup
    sign_in_as users(:user_001)
  end

  test 'search results dom' do
    visit root_url
    assert page.has_selector?('nav.navbar')
    assert page.has_selector?('#facets')
    within('#facets') do
      assert page.has_text?('Publication State')
      assert page.has_text?('Provider')
      assert page.has_text?('Accrual Method')
      assert page.has_text?('Public/Restricted')
    end
    assert page.has_selector?('#resultset')
    within('#resultset') do
      assert page.has_selector?('#results')
    end
  end
end
