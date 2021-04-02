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

  include Statesman::Adapters::ActiveRecordQueries[
    transition_class: DocumentTransition,
    initial_state: :draft
  ]

  def state_machine
    @state_machine ||= DocumentStateMachine.new(self, transition_class: DocumentTransition)
  end

  delegate :current_state, to: :state_machine

  before_save :transition_publication_state, unless: :skip_callbacks

  # Indexer
  self.kithe_indexable_mapper = DocumentIndexer.new

  # Validations
  validates :b1g_status_s, :dct_identifier_sm, :dct_accessRights_s, :gbl_resourceType_sm, presence: true

  # @TODO: Test for collection and restricted
  validates :dct_format_s, presence: true, unless: :a_collection_object?

  # Interactive Resouce
  # Restricted items!
  def a_collection_object?
    dc_type_sm.include?('Collection')
  end

  validates_with Document::DateRangeValidator
  validates_with Document::SolrGeomValidator

  # Form
  # Identification
  # - Descriptive
  attr_json GEOMG.FIELDS.TITLE, :string
  attr_json GEOMG.FIELDS.ALT_TITLE, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.DESCRIPTION, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.LANGUAGE, :string, array: true, default: -> { [] }

  # - Credits
  attr_json GEOMG.FIELDS.CREATOR, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.PUBLISHER, :string, array: true, default: -> { [] }

  # - Categories
  attr_json GEOMG.FIELDS.B1G_GENRE, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.SUBJECT, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.B1G_KEYWORD, :string, array: true, default: -> { [] }

  # - Temporal
  attr_json GEOMG.FIELDS.ISSUED, :string
  attr_json GEOMG.FIELDS.TEMPORAL, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.B1G_DATE_RANGE, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.YEAR, :integer

  # - Spatial
  attr_json GEOMG.FIELDS.SPATIAL, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.B1G_GEONAMES, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.GEOM, :string
  attr_json GEOMG.FIELDS.B1G_CENTROID, :string

  # Distribution
  # - Object
  attr_json GEOMG.FIELDS.TYPE, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.LAYER_GEOM_TYPE, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.LAYER_ID, :string
  attr_json GEOMG.FIELDS.FORMAT, :string

  # - Access Links
  # - Geospatial Web Services
  # - Images
  # - Metadata
  attr_json GEOMG.FIELDS.REFERENCES, Document::Reference.to_type, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.B1G_IMAGE, :string

  # Administrative
  # - Codes
  attr_json GEOMG.FIELDS.IDENTIFIER, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.LAYER_SLUG, :string
  attr_json GEOMG.FIELDS.PROVENANCE, :string
  attr_json GEOMG.FIELDS.B1G_CODE, :string
  attr_json GEOMG.FIELDS.IS_PART_OF, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.SOURCE, :string, array: true, default: -> { [] }

  # - Status
  attr_json GEOMG.FIELDS.B1G_STATUS, :string
  attr_json GEOMG.FIELDS.B1G_ACCRUAL_METHOD, :string
  attr_json GEOMG.FIELDS.B1G_ACCRUAL_PERIODICITY, :string
  attr_json GEOMG.FIELDS.B1G_DATE_ACCESSIONED, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.B1G_DATE_RETIRED, :string

  # - Accessibility
  attr_json GEOMG.FIELDS.RIGHTS, :string
  attr_json GEOMG.FIELDS.ACCESS_RIGHTS, :string, array: true, default: -> { [] }

  # @TODO: Why are booleans not passed in form params?
  attr_json GEOMG.FIELDS.SUPPRESSED, :boolean
  attr_json GEOMG.FIELDS.B1G_CHILD_RECORD, :boolean

  # Index Transformations - *_json functions
  def references_json
    references = {}
    send(GEOMG.FIELDS.REFERENCES).each { |ref| references[Document::Reference::REFERENCE_VALUES[ref.category.to_sym][:uri]] = ref.value }
    references.to_json
  end

  def access_json
    access = {}
    access_urls.each { |au| access[au.institution_code] = au.access_url }
    access.to_json
  end

  def layer_modified_dt
    updated_at&.utc&.iso8601
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
    return nil if send(GEOMG.FIELDS.B1G_DATE_RANGE).blank?

    start_d, _end_d = send(GEOMG.FIELDS.B1G_DATE_RANGE).first.split('-')
    start_d if start_d.presence
  end

  # Export Transformations - to_*
  def to_csv
    attributes = Geomg.field_mappings_btaa

    attributes.map do |key, value|
      if value[:delimited]
        send(value[:destination]).join('|')
      elsif value[:destination] == 'locn_geometry'
        solr_geom_to_csv(value[:destination])
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

  def solr_geom_to_csv(destination)
    wsen_coordinates(send(destination))
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

  private

  # "ENVELOPE(W,E,N,S)" convert to "W,S,E,N"
  def wsen_coordinates(coords)
    # ex. ENVELOPE(-95.0379,-91.198,43.1373,40.6333)
    w, e, n, s = coords[/\((.*?)\)/, 1].split(',')
    "#{w},#{s},#{e},#{n}"
  end

  def transition_publication_state
    state_machine.transition_to!(publication_state.downcase) if publication_state_changed?
  end
end
