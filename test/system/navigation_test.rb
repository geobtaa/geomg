# frozen_string_literal: true

require 'application_system_test_case'

class NavigationTest < ApplicationSystemTestCase
  def setup
    sign_in_as users(:user_001)
  end

  test 'visiting the index' do
    visit root_url
    within('nav.navbar') do
      assert page.has_link?('G·E·O·M·G')
      assert page.has_selector?('form')
      assert page.has_selector?("input[name='q']")
      assert page.has_text?('Admin Tools')
      assert page.has_link?('Documents', visible: false)
      assert page.has_link?('Imports', visible: false)
      assert page.has_link?('Access Links', visible: false)
      assert page.has_link?('Bulk Actions', visible: false)
      assert page.has_link?('Users', visible: false)
      assert page.has_link?('Bookmarks')
      assert page.has_link?('Sign out')
    end
  end
end
