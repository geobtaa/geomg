# frozen_string_literal: true

require "test_helper"

class MappingsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    get "/users/sign_in"
    sign_in_as users(:user_001)
    post user_session_url

    follow_redirect!
    assert_response :success

    @import = imports(:one)
    @mapping = mappings(:one)
  end

  test "should get index" do
    get import_mappings_url(@import)
    assert_response :success
  end

  test "should get new" do
    get new_import_mapping_url(@import)
    assert_response :success
  end

  test "should create mapping" do
    assert_difference("Mapping.count") do
      post import_mappings_url(@import), params: {mapping: {delimited: @mapping.delimited, destination_field: @mapping.destination_field, import_id: @mapping.import_id, source_header: @mapping.source_header, transformation_method: @mapping.transformation_method}}
    end

    assert_redirected_to import_mapping_url(@import, Mapping.last)
  end

  test "should show mapping" do
    get import_mapping_url(@import, @mapping)
    assert_response :success
  end

  test "should get edit" do
    get edit_import_mapping_url(@import, @mapping)
    assert_response :success
  end

  test "should update mapping" do
    patch import_mapping_url(@import, @mapping), params: {mapping: {delimited: @mapping.delimited, destination_field: @mapping.destination_field, import_id: @mapping.import_id, source_header: @mapping.source_header, transformation_method: @mapping.transformation_method}}
    assert_redirected_to import_mappings_url(@import)
  end

  test "should destroy mapping" do
    assert_difference("Mapping.count", -1) do
      delete import_mapping_url(@import, @mapping)
    end

    assert_redirected_to import_mappings_url
  end
end
