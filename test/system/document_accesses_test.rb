require "application_system_test_case"

class DocumentAccessesTest < ApplicationSystemTestCase
  setup do
    sign_in_as users(:user_001)
    @document = documents(:ag)
    @document_access = document_accesses(:one)
  end

  test "visiting the document index" do
    visit document_document_accesses_url(@document)
    assert_selector "h1", text: "Document · Access Links"
  end

  test "creating a Document access" do
    visit document_document_accesses_url(@document)
    click_on "+ New Access URL"

    fill_in "Access url", with: @document_access.access_url
    find('#document_access_institution_code').find(:xpath, 'option[2]').select_option
    click_on "Create Access URL"

    assert_text "Document access was successfully created"
  end

  test "updating a Document access" do
    visit document_document_accesses_url(@document)
    click_on "Edit", match: :first

    fill_in "Access url", with: @document_access.access_url
    find('#document_access_institution_code').find(:xpath, 'option[2]').select_option
    click_on "Create Access URL"

    assert_text "Document access was successfully updated"
  end

  test "destroying a Document access" do
    visit document_document_accesses_url(@document)
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Document access was successfully destroyed"
  end
end
