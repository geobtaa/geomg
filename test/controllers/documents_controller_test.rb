require 'test_helper'

class DocumentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    get '/users/sign_in'
    sign_in users(:user_001)
    post user_session_url

    follow_redirect!
    assert_response :success
  end

  test 'should return index view' do
    get documents_url
    assert_response :success
  end
end
