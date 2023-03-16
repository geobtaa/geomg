# frozen_string_literal: true

require "test_helper"

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    get "/users/sign_in"
    sign_in_as users(:user_001)
    post user_session_url

    follow_redirect!
    assert_response :success
  end

  test "redirects when not logged in" do
    sign_out_as :user_001
    get documents_url
    assert_redirected_to new_user_session_path
  end

  test "should render documents index view" do
    get documents_url
    assert_response :success
  end

  test "should redirect document show view" do
    get "/documents/35c8a641589c4e13b7aa11e37f3f00a1_0"
    assert_redirected_to edit_document_path
  end

  test "should render document#show as csv" do
    get "/documents/35c8a641589c4e13b7aa11e37f3f00a1_0.csv"
    assert_response :success
  end

  test "should render document#show as json_gbl_v1" do
    get "/documents/35c8a641589c4e13b7aa11e37f3f00a1_0.json_gbl_v1"
    assert_response :success
  end

  test "should render document#show as json_btaa_aardvark" do
    get "/documents/35c8a641589c4e13b7aa11e37f3f00a1_0.json_btaa_aardvark"
    assert_response :success
  end

  test "should render document#show as json_aardvark" do
    get "/documents/35c8a641589c4e13b7aa11e37f3f00a1_0.json_aardvark"
    assert_response :success
  end

  test "should render document edit view" do
    get "/documents/35c8a641589c4e13b7aa11e37f3f00a1_0/edit"
    assert_response :success
  end

  test "should render documents#index as json" do
    get documents_url, params: {format: "json"}
    assert_response :success
  end

  test "should render documents#index as json_gbl_v1" do
    get documents_url, params: {format: "json_gbl_v1"}
    assert_response :success
  end

  test "should render documents#index as json_btaa_aardvark" do
    get documents_url, params: {format: "json_btaa_aardvark"}
    assert_response :success
  end

  test "should render documents#index as json_aardvark" do
    get documents_url, params: {format: "json_aardvark"}
    assert_response :success
  end

  test "should render documents#index as csv" do
    skip("@TODO: divorce from geoportal")
    get documents_url, params: {format: "csv"}
    assert_response :success
  end

  test "should map documents/:id/versions to documents#versions" do
    get "/documents/35c8a641589c4e13b7aa11e37f3f00a1_0/versions"
    assert_response :success
  end
end
