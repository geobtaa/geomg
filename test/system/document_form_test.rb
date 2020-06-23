# frozen_string_literal: true

require 'application_system_test_case'

class DocumentFormTest < ApplicationSystemTestCase
  def setup
    sign_in_as users(:user_001)
  end

  def test_basic_dom
    visit '/documents/new'

    assert page.has_selector?('nav.navbar')         # User Nav
    assert page.has_selector?('form#new_document')  # Form
    assert page.has_selector?('div.admin-header')   # Form Header
    assert page.has_selector?('div.form-actions')   # Form Actions
    assert page.has_selector?('#form-fields')       # Form Fields
    assert page.has_selector?('#form-navigation')   # Form Navigation
  end

  def test_form_elements
    visit '/documents/new'
    within('form#new_document') do
      # dc_title_s
      assert page.has_selector?('input#document_title')
      # dct_alternativeTitle_sm
      assert page.has_selector?('input#document_dct_alternativeTitle_sm_attributes_', visible: false)
      # dc_description_s
      assert page.has_selector?('textarea#document_dc_description_s')
      # dc_language_sm
      assert page.has_selector?('input#document_dc_language_sm_attributes_', visible: false)
    end
  end
end
