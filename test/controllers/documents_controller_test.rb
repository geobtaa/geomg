require 'test_helper'

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    get '/users/sign_in'
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

  test 'should render documents index view' do
    get documents_url
    assert_response :success
  end

  test 'should render document show view' do
    get '/documents/testhashid'
    assert_response :success
  end

  test "should render document edit view" do
    get '/documents/testhashid/edit'
    assert_response :success
  end
end
