# frozen_string_literal: true

require "test_helper"

class ApplicationHelperTest < ActionView::TestCase
  attr_reader :current_user

  setup do
    @current_user = users(:user_001)
  end

  test "diff_class" do
    assert_equal "table-warning", diff_class("~")
    assert_equal "table-danger", diff_class("-")
    assert_equal "table-success", diff_class("+")
    assert_equal "", diff_class("foo")
  end

  test "no_json_blanks" do
    assert_equal "foo", no_json_blanks("foo")
    assert_nil no_json_blanks([""])
    assert_equal ["foo", "bar"], no_json_blanks(["foo", "bar"])
  end

  test "qa_search_vocab_path" do
    assert_equal "/authorities/search/foo", qa_search_vocab_path("foo")
    assert_equal "/authorities/search/foo/bar", qa_search_vocab_path("foo", "bar")
  end

  test "flash_class" do
    assert_equal "alert alert-info", flash_class("notice")
    assert_equal "alert alert-success", flash_class("success")
    assert_equal "alert alert-error", flash_class("error")
    assert_equal "alert alert-error", flash_class("alert")
  end

  test "b1g_institution_codes" do
    bic = {
      "01" => "Indiana University",
      "02" => "University of Illinois Urbana-Champaign",
      "03" => "University of Iowa",
      "04" => "University of Maryland",
      "05" => "University of Minnesota",
      "06" => "Michigan State University",
      "07" => "University of Michigan",
      "08" => "Purdue University",
      "09" => "Pennsylvania State University",
      "10" => "University of Wisconsin-Madison",
      "11" => "The Ohio State University",
      "12" => "University of Chicago",
      "13" => "University of Nebraska-Lincoln",
      "14"=>"Rutgers University-New Brunswick"
    }

    assert_equal bic, b1g_institution_codes
  end

  test "notifications_badge" do
    assert_equal "<span class='badge badge-dark' id='notification-count'>0</span>", notifications_badge
  end

  test "flat_hash_key" do
    assert_equal "foo[bar]", flat_hash_key(["foo", "bar"])
  end

  test "flatten_hash" do
    flat_hash = {"foo[bar]" => "baz"}
    assert_equal flat_hash, flatten_hash({foo: {bar: "baz"}})
  end

  test "params_as_hidden_fields" do
    assert_equal "<input type=\"hidden\" name=\"q\" value=\"foo\" autocomplete=\"off\" />", params_as_hidden_fields({"q" => "foo"})
  end
end
