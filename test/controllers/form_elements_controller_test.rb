require "test_helper"

class FormElementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @form_element = form_elements(:header)

    get '/users/sign_in'
    sign_in_as users(:user_001)
    post user_session_url

    follow_redirect!
    assert_response :success
  end

  test "should get index" do
    get form_elements_url
    assert_response :success
  end

  test "should get new" do
    get new_form_element_url
    assert_response :success
  end

  test "should create form_element" do
    assert_difference('FormElement.count') do
      post form_elements_url, params: { form_element: { element_id: @form_element.element_id, label: @form_element.label, type: @form_element.type } }
    end

    assert_redirected_to form_elements_url
  end

  test "should show form_element" do
    get form_element_url(@form_element)
    assert_response :success
  end

  test "should get edit" do
    get edit_form_element_url(@form_element)
    assert_response :success
  end

  test "should update form_element" do
    patch form_element_url(@form_element), params: { form_element: { element_id: @form_element.element_id, label: @form_element.label, type: @form_element.type } }
    assert_redirected_to form_element_url(@form_element)
  end

  test "should destroy form_element" do
    assert_difference('FormElement.count', -1) do
      delete form_element_url(@form_element)
    end

    assert_redirected_to form_elements_url
  end
end
