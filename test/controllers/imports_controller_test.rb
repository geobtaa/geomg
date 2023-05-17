# frozen_string_literal: true

require "test_helper"

class ImportsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    get "/users/sign_in"
    sign_in_as users(:user_001)
    post user_session_url

    follow_redirect!
    assert_response :success

    @import = imports(:one)
  end

  test "should get index" do
    get imports_url
    assert_response :success
  end

  test "should get new" do
    get new_import_url
    assert_response :success
  end

  test "should create import" do
    skip("file download missing in test runner")
    assert_difference("Import.count") do
      post imports_url, params: {import: {content_type: @import.content_type, description: @import.description, encoding: @import.encoding, extension: @import.extension, filename: @import.filename, headers: @import.headers, name: @import.name, row_count: @import.row_count, source: @import.source, validity: @import.validity, validation_result: @import.validation_result, csv_file: fixture_file_upload("files/btaa_formatted_records.csv", "text/csv"), type: @import.type}}
    end

    assert_redirected_to import_mappings_url(Import.last)
  end

  test "should redirect bad headers" do
    skip("file download missing in test runner")
    @import = imports(:two)
    assert_no_difference("Import.count") do
      post imports_url, params: {import: {content_type: @import.content_type, description: @import.description, encoding: @import.encoding, extension: @import.extension, filename: @import.filename, headers: @import.headers, name: @import.name, row_count: @import.row_count, source: @import.source, validity: @import.validity, validation_result: @import.validation_result, csv_file: fixture_file_upload("files/btaa_formatted_records.csv", "text/csv"), type: @import.type}}
    end
  end

  test "should show import" do
    skip("@TODO: Blob link to test attachment not working?")
    get import_url(@import)
    assert_response :success
  end

  test "should get edit" do
    get edit_import_url(@import)
    assert_response :success
  end

  test "should update import" do
    skip("file download missing in test runner")
    patch import_url(@import), params: {import: {content_type: @import.content_type, description: @import.description, encoding: @import.encoding, extension: @import.extension, filename: @import.filename, headers: @import.headers, name: @import.name, row_count: @import.row_count, source: @import.source, validity: @import.validity, validation_result: @import.validation_result, csv_file: fixture_file_upload("files/btaa_formatted_records.csv", "text/csv"), type: @import.type}}

    assert_redirected_to import_url(@import)
  end

  test "should destroy import" do
    assert_difference("Import.count", -1) do
      delete import_url(@import)
    end

    assert_redirected_to imports_url
  end

  test "validation - no dupliate ids allowed" do
    skip("file download missing in test runner")
    assert_no_difference("Import.count") do
      post imports_url, params: {import: {name: "Test", csv_file: fixture_file_upload("#{Rails.root}/test/fixtures/files/duplicate_ids.csv", "text/csv")}}
    end
  end
end
