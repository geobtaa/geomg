
# frozen_string_literal: true

# Document
class Document < Kithe::Work
  include AttrJson::Record::QueryScopes
  include ActiveModel::Validations

  attr_accessor :skip_callbacks

  has_paper_trail
  belongs_to :import, optional: true

  # Statesman
  has_many :document_transitions, foreign_key: 'kithe_model_id', autosave: false, dependent: :destroy, inverse_of: :document

  # DocumentAccesses
  has_many :document_accesses, primary_key: 'friendlier_id', foreign_key: 'friendlier_id', autosave: false, dependent: :destroy,
                               inverse_of: :document

  # DocumentDownloads
  has_many :document_downloads, primary_key: 'friendlier_id', foreign_key: 'friendlier_id', autosave: false, dependent: :destroy,
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
    references_json.include?('downloadUrl')
  end

  validates_with Document::DateRangeValidator
  validates_with Document::BboxValidator
  validates_with Document::GeomValidator

  # Form
  # Identification
  # - Descriptive
  attr_json GEOMG.FIELDS.TITLE.to_sym, :string
  attr_json GEOMG.FIELDS.ALT_TITLE.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.DESCRIPTION.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.LANGUAGE.to_sym, :string, array: true, default: -> { [] }

  # - Credits
  attr_json GEOMG.FIELDS.CREATOR.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.PUBLISHER.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.B1G_CREATOR_ID.to_sym, :string, array: true, default: -> { [] }

  # - Categories
  attr_json GEOMG.FIELDS.B1G_GENRE.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.SUBJECT.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.THEME.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.B1G_KEYWORD.to_sym, :string, array: true, default: -> { [] }

  # - Temporal
  attr_json GEOMG.FIELDS.ISSUED.to_sym, :string
  attr_json GEOMG.FIELDS.TEMPORAL.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.B1G_DATE_RANGE.to_sym, :string, array: true, default: -> { [] }
  # GEOMG.FIELDS.YEAR.to_sym is derived via self.solr_year_json

  # - Spatial
  attr_json GEOMG.FIELDS.SPATIAL.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.B1G_GEONAMES.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.GEOM.to_sym, :string
  attr_json GEOMG.FIELDS.BBOX.to_sym, :string
  attr_json GEOMG.FIELDS.B1G_CENTROID.to_sym, :string
  attr_json GEOMG.FIELDS.CENTROID.to_sym, :string

  # - Relations
  attr_json GEOMG.FIELDS.RELATION.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.MEMBER_OF.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.IS_VERSION_OF.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.REPLACES.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.IS_REPLACED_BY.to_sym, :string, array: true, default: -> { [] }

  # Distribution
  # - Object
  attr_json GEOMG.FIELDS.LAYER_GEOM_TYPE.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.LAYER_ID.to_sym, :string
  attr_json GEOMG.FIELDS.FORMAT.to_sym, :string
  attr_json GEOMG.FIELDS.FILE_SIZE.to_sym, :string
  attr_json GEOMG.FIELDS.GEOREFERENCED.to_sym, :boolean

  # - Access Links
  # - Geospatial Web Services
  # - Images
  # - Metadata
  attr_json GEOMG.FIELDS.REFERENCES.to_sym, Document::Reference.to_type, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.B1G_IMAGE.to_sym, :string

  # Administrative
  # - Codes
  attr_json GEOMG.FIELDS.IDENTIFIER.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.LAYER_SLUG.to_sym, :string
  attr_json GEOMG.FIELDS.PROVENANCE.to_sym, :string
  attr_json GEOMG.FIELDS.B1G_CODE.to_sym, :string
  attr_json GEOMG.FIELDS.IS_PART_OF.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.SOURCE.to_sym, :string, array: true, default: -> { [] }

  # - Rights
  attr_json GEOMG.FIELDS.LICENSE.to_sym, :string, array: true, default: -> { [] }

  # - Life Cycle
  attr_json GEOMG.FIELDS.B1G_ACCRUAL_METHOD.to_sym, :string
  attr_json GEOMG.FIELDS.B1G_ACCRUAL_PERIODICITY.to_sym, :string
  attr_json GEOMG.FIELDS.B1G_DATE_ACCESSIONED.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.B1G_DATE_RETIRED.to_sym, :string
  attr_json GEOMG.FIELDS.B1G_STATUS.to_sym, :string

  # - Accessibility
  attr_json GEOMG.FIELDS.ACCESS_RIGHTS.to_sym, :string
  attr_json GEOMG.FIELDS.RIGHTS_HOLDER.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.RIGHTS.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.B1G_MEDIATOR.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.B1G_ACCESS.to_sym, :string
  attr_json GEOMG.FIELDS.SUPPRESSED.to_sym, :boolean
  attr_json GEOMG.FIELDS.B1G_CHILD_RECORD.to_sym, :boolean

  # Index Transformations - *_json functions
  def references_json
    references = ActiveSupport::HashWithIndifferentAccess.new
    send(GEOMG.FIELDS.REFERENCES).each { |ref| references[Document::Reference::REFERENCE_VALUES[ref.category.to_sym][:uri]] = ref.value }
    references = apply_downloads(references)
    references.to_json
  end

  def apply_downloads(references)
    dct_downloads = references['http://schema.org/downloadUrl']
    # Make sure downloads exist!
    if document_downloads.present?
      multiple_downloads = multiple_downloads_array
      multiple_downloads << { label: download_text(send(GEOMG.FIELDS.FORMAT)), url: dct_downloads } if dct_downloads.present?
      references.merge!({ 'http://schema.org/downloadUrl': multiple_downloads })
    end
    references
  end

  def multiple_downloads_array
    document_downloads.collect { |d| { label: d.label, url: d.value } }
  end

  ### From GBL
  ##
  # Looks up properly formatted names for formats
  #
  def proper_case_format(format)
    if I18n.exists?("geoblacklight.formats.#{format.to_s.parameterize(separator: '_')}")
      I18n.t("geoblacklight.formats.#{format.to_s.parameterize(separator: '_')}")
    else
      format
    end
  end

  ##
  # Wraps download text with proper_case_format
  #
  def download_text(format)
    download_format = proper_case_format(format)
    prefix = 'Original '
    begin
      format = download_format
    rescue StandardError
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

  def gbl_mdModified_dt
    updated_at&.utc&.iso8601
  end

  # Ensures a manually created "title" makes it into the attr_json "title"
  def dct_title_s
    title
  end

  def date_range_json
    date_ranges = []
    send(GEOMG.FIELDS.B1G_DATE_RANGE).each do |date_range|
      start_d, end_d = date_range.split('-')
      start_d = '*' if start_d == 'YYYY' || start_d.nil?
      end_d   = '*' if end_d == 'YYYY' || end_d.nil?
      date_ranges << "[#{start_d} TO #{end_d}]" if start_d.present?
    end
    date_ranges
  end

  def solr_year_json
    return [] if send(GEOMG.FIELDS.B1G_DATE_RANGE).blank?

    start_d, _end_d = send(GEOMG.FIELDS.B1G_DATE_RANGE).first.split('-')
    [start_d] if start_d.presence
  end
  alias gbl_indexYear_im solr_year_json

  # Export Transformations - to_*
  def to_csv
    attributes = Geomg.field_mappings_btaa
    attributes.map do |key, value|
      if value[:delimited]
        send(value[:destination]).join('|')
      elsif value[:destination] == 'dct_references_s'
        dct_references_s_to_csv(key, value[:destination])
      else
        send(value[:destination])
      end
    end
  end

  def dct_references_s_to_csv(key, destination)
    send(destination).detect { |ref| ref.category == Geomg.dct_references_mappings[key] }.value
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
    if send(GEOMG.FIELDS.GEOM).present?
      send(GEOMG.FIELDS.GEOM)
    elsif send(GEOMG.FIELDS.BBOX).present?
      derive_polygon
    else
      ''
    end
  end

  # Convert BBOX to GEOM Polygon
  def derive_polygon
    if send(GEOMG.FIELDS.BBOX).present?
      # Guard against a whole world polygons
      if send(GEOMG.FIELDS.BBOX) == '-180,-90,180,90'
        "ENVELOPE(-180,180,90,-90)"
      else
        # "W,S,E,N" convert to "POLYGON((W N, E N, E S, W S, W N))"
        w, s, e, n = send(GEOMG.FIELDS.BBOX).split(',')
        "POLYGON((#{w} #{n}, #{e} #{n}, #{e} #{s}, #{w} #{s}, #{w} #{n}))"
      end
    else
     ''
    end
  end

  def set_geometry
    if self.locn_geometry.blank? && self&.dcat_bbox&.present?
      self.locn_geometry = derive_polygon
    end
  end

  # Convert GEOM for Solr Indexing
  def derive_dcat_bbox
    if send(GEOMG.FIELDS.BBOX).present?
      # "W,S,E,N" convert to "ENVELOPE(W,E,N,S)"
      w, s, e, n = send(GEOMG.FIELDS.BBOX).split(',')
      "ENVELOPE(#{w},#{e},#{n},#{s})"
    else
      ''
    end
  end

  def derive_dcat_centroid
    if send(GEOMG.FIELDS.BBOX).present?
      w, s, e, n = send(GEOMG.FIELDS.BBOX).split(',')
      "#{(n.to_f + s.to_f) / 2},#{(e.to_f + w.to_f) / 2}"
    else
      ''
    end
  end

  # Convert three char language code to proper string
  def iso_language_mapping
    mapping = []
    if send(GEOMG.FIELDS.LANGUAGE).present?
      send(GEOMG.FIELDS.LANGUAGE).each do |lang|
        mapping << Geomg.iso_language_codes[lang]
      end
    end
    mapping
  end

  private

  def transition_publication_state
    state_machine.transition_to!(publication_state.downcase) if publication_state_changed?
  end
end
