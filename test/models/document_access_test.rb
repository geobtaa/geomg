require "test_helper"

class DocumentAccessTest < ActiveSupport::TestCase
  def setup
    @document_access = DocumentAccess.new
  end

  # Attrs
  test "responds to friendlier_id" do
    assert_respond_to @document_access, :friendlier_id
  end

  test "responds to institution_code" do
    assert_respond_to @document_access, :institution_code
  end

  test "responds to access_url" do
    assert_respond_to @document_access, :access_url
  end

  # Validations
  test "class validations" do
    assert @document_access.invalid?

    # Required
    @document_access.friendlier_id = "foo"
    @document_access.save
    assert @document_access.invalid?
    assert @document_access.errors

    # Required
    @document_access.institution_code = "01"
    @document_access.save
    assert @document_access.invalid?
    assert @document_access.errors

    # Required
    @document_access.access_url = "http://google.com"
    assert_nothing_raised do
      @document_access.save
    end
  end

  # Class Methods
  test "responds to import" do
    assert_respond_to DocumentAccess, :import
  end
end
