require 'test_helper'

class BulkActionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bulk_action = bulk_actions(:one)
  end

  test "should get index" do
    get bulk_actions_url
    assert_response :success
  end

  test "should get new" do
    get new_bulk_action_url
    assert_response :success
  end

  test "should create bulk_action" do
    skip("@TODO")
    assert_difference('BulkAction.count') do
      post bulk_actions_url, params: { bulk_action: {  } }
    end

    assert_redirected_to bulk_action_url(BulkAction.last)
  end

  test "should show bulk_action" do
    skip("@TODO")
    get bulk_action_url(@bulk_action)
    assert_response :success
  end

  test "should get edit" do
    skip("@TODO")
    get edit_bulk_action_url(@bulk_action)
    assert_response :success
  end

  test "should update bulk_action" do
    skip("@TODO")
    patch bulk_action_url(@bulk_action), params: { bulk_action: {  } }
    assert_redirected_to bulk_action_url(@bulk_action)
  end

  test "should destroy bulk_action" do
    skip("@TODO")
    assert_difference('BulkAction.count', -1) do
      delete bulk_action_url(@bulk_action)
    end

    assert_redirected_to bulk_actions_url
  end
end
