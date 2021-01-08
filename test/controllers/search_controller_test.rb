require 'test_helper'

class SearchControllerTest < ActionDispatch::IntegrationTest
  setup do
    get '/users/sign_in'
    sign_in_as users(:user_001)
    post user_session_url

    follow_redirect!
    assert_response :success
  end

  test "should get index" do
    get '/search'
    assert_response :success
  end
end
