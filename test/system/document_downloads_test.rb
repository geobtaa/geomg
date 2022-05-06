require "application_system_test_case"

class DocumentDownloadsTest < ApplicationSystemTestCase
  setup do
    sign_in_as users(:user_001)
    @document = documents(:ag)
    @document_download = document_downloads(:one)
  end

  test "visiting the index" do
    visit document_document_downloads_url(@document)
    assert_selector "h1", text: "Document · Download Links"
  end

  test "creating a Document download" do
    visit document_document_downloads_url(@document)
    click_on "+ New Download URL"

    # fill_in "Friendlier", with: @document_download.friendlier_id
    fill_in "Label", with: @document_download.label
    # @TODO: Position is hidden for now
    # fill_in "Position", with: @document_download.position
    fill_in "Download URL", with: @document_download.value
    click_on "Create Download URL"

    assert_text "Document download was successfully created"
  end

  test "updating a Document download" do
    visit document_document_downloads_url(@document)
    click_on "Edit", match: :first

    # fill_in "Friendlier", with: @document_download.friendlier_id
    fill_in "Label", with: @document_download.label
    # @TODO: Position is hidden for now
    # fill_in "Position", with: @document_download.position
    fill_in "Download URL", with: @document_download.value
    click_on "Create Download URL"

    assert_text "Document download was successfully updated"
  end

  test "destroying a Document download" do
    visit document_document_downloads_url(@document)
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Document download was successfully destroyed"
  end
end
