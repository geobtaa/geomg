require "application_system_test_case"

class DocumentFormTest < ApplicationSystemTestCase
  def setup
    sign_in_as users(:user_001)
  end

  def test_basic_dom
    visit "/documents/new"

    assert page.has_selector?("p.navbar-text")      # User Nav
    assert page.has_selector?("form#new_document")  # Form
    assert page.has_selector?("div.admin-header")   # Form Header
    assert page.has_selector?("div.form-actions")   # Form Actions
    assert page.has_selector?("#form-fields")       # Form Fields
    assert page.has_selector?("#form-navigation")   # Form Navigation
  end
end
