require 'test_helper'

class DocumentAccessesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @document = documents(:ag)
    @document_access = document_accesses(:one)

    get '/users/sign_in'
    sign_in_as users(:user_001)
    post user_session_url

    follow_redirect!
    assert_response :success
  end

  test "should get index" do
    get document_accesses_url
    assert_response :success
  end

  test "should get import" do
    get import_document_accesses_url
    assert_response :success
  end

  test "should get document index" do
    get document_document_accesses_url(@document)
    assert_response :success
  end

  test "should get document import" do
    get import_document_document_accesses_url(@document)
    assert_response :success
  end

  test "should get new" do
    get new_document_document_access_url(@document)
    assert_response :success
  end

  test "should create document_access" do
    assert_difference('DocumentAccess.count') do
      post document_document_accesses_url(@document), params: { document_access: { access_url: @document_access.access_url, institution_code: @document_access.institution_code, friendlier_id: @document_access.friendlier_id } }
    end

    assert_redirected_to document_document_accesses_url(@document)
  end

  test "should show document_access" do
    get document_document_accesses_url(@document, @document_access)
    assert_response :success
  end

  test "should get edit" do
    get edit_document_document_access_url(@document, @document_access)
    assert_response :success
  end

  test "should update document_access" do
    patch document_document_access_url(@document, @document_access), params: { document_access: { access_url: @document_access.access_url, institution_code: @document_access.institution_code, friendlier_id: @document_access.friendlier_id } }
    assert_redirected_to document_document_accesses_url(@document)
  end

  test "should destroy document_access" do
    assert_difference('DocumentAccess.count', -1) do
      delete document_document_access_url(@document, @document_access)
    end

    assert_redirected_to document_document_accesses_url(@document)
  end
end
