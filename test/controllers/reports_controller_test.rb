require "test_helper"

class ReportsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reports_index_url
    assert_response :success
  end

  test "should get overview" do
    get reports_overview_url
    assert_response :success
  end
end
