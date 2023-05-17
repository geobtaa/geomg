require "test_helper"

class ImportDocumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    get "/users/sign_in"
    sign_in_as users(:user_001)
    post user_session_url

    follow_redirect!
    assert_response :success

    @import = imports(:one)
    @import_document = import_documents(:ag)
  end

  test "should get show" do
    get import_import_document_url(@import, @import_document)
    assert_response :success
  end
end
