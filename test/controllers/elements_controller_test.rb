require "test_helper"

class ElementsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    Rails.application.load_seed
    @element = Element.find_by(solr_field: "dct_title_s")
    get "/users/sign_in"
    sign_in_as users(:user_001)
    post user_session_url

    follow_redirect!
    assert_response :success
  end

  test "should get index" do
    get elements_url
    assert_response :success
  end

  test "should get new" do
    get new_element_url
    assert_response :success
  end

  test "should create element" do
    assert_difference("Element.count") do
      post elements_url, params: {element: {controlled_vocabulary: @element.controlled_vocabulary, data_entry_hint: @element.data_entry_hint, display_only_on_persisted: @element.display_only_on_persisted, export_transformation_method: @element.export_transformation_method, exportable: @element.exportable, field_definition: @element.field_definition, field_type: @element.field_type, formable: @element.formable, html_attributes: @element.html_attributes, import_deliminated: @element.import_deliminated, import_transformation_method: @element.import_transformation_method, importable: @element.importable, index_transformation_method: @element.index_transformation_method, indexable: @element.indexable, js_behaviors: @element.js_behaviors, label: @element.label, placeholder_text: @element.placeholder_text, repeatable: @element.repeatable, required: @element.required, solr_field: @element.solr_field, test_fixture_example: @element.test_fixture_example, validation_method: @element.validation_method}}
    end

    assert_redirected_to element_url(Element.last)
  end

  test "should show element" do
    get element_url(@element)
    assert_response :success
  end

  test "should get edit" do
    get edit_element_url(@element)
    assert_response :success
  end

  test "should update element" do
    patch element_url(@element), params: {element: {controlled_vocabulary: @element.controlled_vocabulary, data_entry_hint: @element.data_entry_hint, display_only_on_persisted: @element.display_only_on_persisted, export_transformation_method: @element.export_transformation_method, exportable: @element.exportable, field_definition: @element.field_definition, field_type: @element.field_type, formable: @element.formable, html_attributes: @element.html_attributes, import_deliminated: @element.import_deliminated, import_transformation_method: @element.import_transformation_method, importable: @element.importable, index_transformation_method: @element.index_transformation_method, indexable: @element.indexable, js_behaviors: @element.js_behaviors, label: @element.label, placeholder_text: @element.placeholder_text, repeatable: @element.repeatable, required: @element.required, solr_field: @element.solr_field, test_fixture_example: @element.test_fixture_example, validation_method: @element.validation_method}}
    assert_redirected_to element_url(@element)
  end

  test "should destroy element" do
    assert_difference("Element.count", -1) do
      delete element_url(@element)
    end

    assert_redirected_to elements_url
  end
end
