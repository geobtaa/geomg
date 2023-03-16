require "test_helper"

class ElementTest < ActiveSupport::TestCase
  def setup
    @element = Element.new
  end

  # Attrs
  test "responds to list" do
    assert_respond_to Element, :list
  end

  test "list" do
    assert_equal Element.list, [:title, :alternative_title, :description, :language, :b1g_language, :creator, :creator_id, :publisher, :provider, :resource_class, :resource_type, :subject, :theme, :keyword, :temporal_coverage, :date_issued, :index_year, :date_range, :spatial_coverage, :bounding_box, :geometry, :centroid, :geonames, :relation, :member_of, :is_part_of, :source, :is_version_of, :replaces, :is_replaced_by, :format, :file_size, :wxs_identifier, :georeferenced, :reference, :b1g_image_url, :id, :identifier, :code, :access_rights, :rights_holder, :license, :rights, :accrual_method, :accrual_periodicity, :date_accessioned, :date_retired, :status, :publication_state, :suppressed_record, :child_record, :mediator, :access, :created_at, :updated_at]
  end

  test "export_value" do
    @element = Element.find_by(solr_field: "dct_title_s")
    assert_equal @element.export_value, "dct_title_s"
  end

  test "self.label_nocase" do
    @element = Element.find_by(solr_field: "dct_title_s")
    assert_equal Element.send(:label_nocase, "title"), @element
  end

  test "self.at" do
    @element = Element.find_by(solr_field: "dct_title_s")
    assert_equal Element.send(:at, "dct_title_s"), @element
  end

  test "success - responds to method_missing" do
    assert_kind_of Element, Element.title
  end

  test "fail - responds to method_missing" do
    assert_raise NoMethodError do
      Element.foo
    end
  end
end
