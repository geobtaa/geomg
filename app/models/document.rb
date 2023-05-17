# frozen_string_literal: true

# Document
class Document < Kithe::Work
  include AttrJson::Record::QueryScopes
  include ActiveModel::Validations

  attr_accessor :skip_callbacks

  has_paper_trail
  belongs_to :import, optional: true

  # Statesman
  has_many :document_transitions, foreign_key: "kithe_model_id", autosave: false, dependent: :destroy, inverse_of: :document

  # DocumentAccesses
  has_many :document_accesses, primary_key: "friendlier_id", foreign_key: "friendlier_id", autosave: false, dependent: :destroy,
    inverse_of: :document

  # DocumentDownloads
  has_many :document_downloads, primary_key: "friendlier_id", foreign_key: "friendlier_id", autosave: false, dependent: :destroy,
    inverse_of: :document

  include Statesman::Adapters::ActiveRecordQueries[
    transition_class: DocumentTransition,
    initial_state: :draft
  ]

  def state_machine
    @state_machine ||= DocumentStateMachine.new(self, transition_class: DocumentTransition)
  end

  delegate :current_state, to: :state_machine

  before_save :transition_publication_state, unless: :skip_callbacks
  before_save :set_geometry

  # Indexer
  self.kithe_indexable_mapper = DocumentIndexer.new

  # Validations
  validates :title, :dct_accessRights_s, :gbl_resourceClass_sm, :geomg_id_s, presence: true

  # Test for collection and restricted
  validates :dct_format_s, presence: true, if: :a_downloadable_resource?

  # Downloadable Resouce
  def a_downloadable_resource?
    references_json.include?("downloadUrl")
  end

  validates_with Document::DateRangeValidator
  validates_with Document::BboxValidator
  validates_with Document::GeomValidator

  # Definte our AttrJSON attributes
  Element.all.each do |attribute|
    next if attribute.solr_field == "dct_references_s"

    if attribute.repeatable?
      attr_json attribute.solr_field.to_sym, attribute.field_type.to_sym, array: true, default: -> { [] }
    else
      attr_json attribute.solr_field.to_sym, attribute.field_type.to_sym, default: ""
    end
  end

  attr_json :dct_references_s, Document::Reference.to_type, array: true, default: -> { [] }

  # Index Transformations - *_json functions
  def references_json
    references = ActiveSupport::HashWithIndifferentAccess.new
    send(Geomg::Schema.instance.solr_fields[:reference]).each { |ref| references[Document::Reference::REFERENCE_VALUES[ref.category.to_sym][:uri]] = ref.value }
    references = apply_downloads(references)
    references.to_json
  end

  def apply_downloads(references)
    dct_downloads = references["http://schema.org/downloadUrl"]
    # Make sure downloads exist!
    if document_downloads.present?
      multiple_downloads = multiple_downloads_array
      multiple_downloads << {label: download_text(send(Geomg::Schema.instance.solr_fields[:format])), url: dct_downloads} if dct_downloads.present?
      references[:"http://schema.org/downloadUrl"] = multiple_downloads
    end
    references
  end

  def multiple_downloads_array
    document_downloads.collect { |d| {label: d.label, url: d.value} }
  end

  ### From GBL
  ##
  # Looks up properly formatted names for formats
  #
  def proper_case_format(format)
    if I18n.exists?("geoblacklight.formats.#{format.to_s.parameterize(separator: "_")}")
      I18n.t("geoblacklight.formats.#{format.to_s.parameterize(separator: "_")}")
    else
      format
    end
  end

  ##
  # Wraps download text with proper_case_format
  #
  def download_text(format)
    download_format = proper_case_format(format)
    prefix = "Original "
    begin
      format = download_format
    rescue
      # Need to rescue if format doesn't exist
    end
    value = prefix + format.to_s
    value.html_safe
  end
  ### End / From GBL

  def access_json
    access = {}
    access_urls.each { |au| access[au.institution_code] = au.access_url }
    access.to_json
  end

  def created_at_dt
    created_at&.utc&.iso8601
  end

  def gbl_mdModified_dt
    updated_at&.utc&.iso8601
  end

  # Ensures a manually created "title" makes it into the attr_json "title"
  def dct_title_s
    title
  end

  def date_range_json
    date_ranges = []
    unless send(Geomg::Schema.instance.solr_fields[:date_range]).all?(&:blank?)
      send(Geomg::Schema.instance.solr_fields[:date_range]).each do |date_range|
        start_d, end_d = date_range.split("-")
        start_d = "*" if start_d == "YYYY" || start_d.nil?
        end_d = "*" if end_d == "YYYY" || end_d.nil?
        date_ranges << "[#{start_d} TO #{end_d}]" if start_d.present?
      end
    end
    date_ranges
  end

  def solr_year_json
    return [] if send(Geomg::Schema.instance.solr_fields[:date_range]).blank?

    start_d, _end_d = send(Geomg::Schema.instance.solr_fields[:date_range]).first.split("-")
    [start_d] if start_d.presence
  end
  alias_method :gbl_indexYear_im, :solr_year_json

  # Export Transformations - to_*
  def to_csv
    attributes = Geomg::Schema.instance.exportable_fields
    attributes.map do |key, value|
      if value[:delimited]
        send(value[:destination])&.join("|")
      elsif value[:destination] == "dct_references_s"
        dct_references_s_to_csv(key, value[:destination])
      elsif value[:destination] == "b1g_publication_state_s"
        send(:current_state)
      else
        send(value[:destination])
      end
    end
  end

  def to_traject
    Kithe::Model.find_by_friendlier_id(friendlier_id).update_index(writer: Traject::DebugWriter.new({}))
  end

  def dct_references_s_to_csv(key, destination)
    send(destination).detect { |ref| ref.category == Geomg::Schema.instance.dct_references_mappings[key] }.value
  rescue NoMethodError
    nil
  end

  def current_version
    versions.last.index
  end

  # Institutional Access URLs
  def access_urls
    DocumentAccess.where(friendlier_id: friendlier_id).order(institution_code: :asc)
  end

  def derive_locn_geometry
    if send(Geomg::Schema.instance.solr_fields[:geometry]).present?
      send(Geomg::Schema.instance.solr_fields[:geometry])
    elsif send(Geomg::Schema.instance.solr_fields[:bounding_box]).present?
      derive_polygon
    else
      ""
    end
  end

  # Convert BBOX to GEOM Polygon
  def derive_polygon
    if send(Geomg::Schema.instance.solr_fields[:bounding_box]).present?
      # Guard against a whole world polygons
      if send(Geomg::Schema.instance.solr_fields[:bounding_box]) == "-180,-90,180,90"
        "ENVELOPE(-180,180,90,-90)"
      else
        # "W,S,E,N" convert to "POLYGON((W N, E N, E S, W S, W N))"
        w, s, e, n = send(Geomg::Schema.instance.solr_fields[:bounding_box]).split(",")
        "POLYGON((#{w} #{n}, #{e} #{n}, #{e} #{s}, #{w} #{s}, #{w} #{n}))"
      end
    else
      ""
    end
  end

  def set_geometry
    if locn_geometry.blank? && self&.dcat_bbox&.present?
      self.locn_geometry = derive_polygon
    end
  end

  # Convert GEOM for Solr Indexing
  def derive_dcat_bbox
    if send(Geomg::Schema.instance.solr_fields[:bounding_box]).present?
      # "W,S,E,N" convert to "ENVELOPE(W,E,N,S)"
      w, s, e, n = send(Geomg::Schema.instance.solr_fields[:bounding_box]).split(",")
      "ENVELOPE(#{w},#{e},#{n},#{s})"
    else
      ""
    end
  end

  def derive_dcat_centroid
    if send(Geomg::Schema.instance.solr_fields[:bounding_box]).present?
      w, s, e, n = send(Geomg::Schema.instance.solr_fields[:bounding_box]).split(",")
      "#{(n.to_f + s.to_f) / 2},#{(e.to_f + w.to_f) / 2}"
    else
      ""
    end
  end

  # Convert three char language code to proper string
  def iso_language_mapping
    mapping = []

    if send(Geomg::Schema.instance.solr_fields[:language]).present?
      send(Geomg::Schema.instance.solr_fields[:language]).each do |lang|
        mapping << Geomg::IsoLanguageCodes.call[lang]
      end
    end
    mapping
  end

  private

  def transition_publication_state
    state_machine.transition_to!(publication_state.downcase) if publication_state_changed?
  end
end
