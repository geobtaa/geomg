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
  validates :b1g_status_s, :dct_identifier_sm, :dct_accessRights_s, :gbl_resourceClass_sm, presence: true

  # Test for collection and restricted
  validates :dct_format_s, presence: true, if: :a_downloadable_resource?

  # Downloadable Resouce
  def a_downloadable_resource?
    references_json.include?('downloadUrl')
  end

  validates_with Document::DateRangeValidator
  validates_with Document::SolrGeomValidator

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

  # - Categories
  attr_json GEOMG.FIELDS.B1G_GENRE.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.SUBJECT.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.THEME.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.B1G_KEYWORD.to_sym, :string, array: true, default: -> { [] }

  # - Temporal
  attr_json GEOMG.FIELDS.ISSUED.to_sym, :string
  attr_json GEOMG.FIELDS.TEMPORAL.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.B1G_DATE_RANGE.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.YEAR.to_sym, :integer, array: true, default: -> { [] }

  # - Spatial
  attr_json GEOMG.FIELDS.SPATIAL.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.B1G_GEONAMES.to_sym, :string, array: true, default: -> { [] }
  attr_json GEOMG.FIELDS.GEOM.to_sym, :string
  attr_json GEOMG.FIELDS.B1G_CENTROID.to_sym, :string

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
    references = {}
    send(GEOMG.FIELDS.REFERENCES).each { |ref| references[Document::Reference::REFERENCE_VALUES[ref.category.to_sym][:uri]] = ref.value }
    references.to_json
  end

  def access_json
    access = {}
    access_urls.each { |au| access[au.institution_code] = au.access_url }
    access.to_json
  end

  def gbl_mdModified_dt
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
    return [] if send(GEOMG.FIELDS.B1G_DATE_RANGE).blank?

    start_d, _end_d = send(GEOMG.FIELDS.B1G_DATE_RANGE).first.split('-')
    [start_d] if start_d.presence
  end

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

  # Convert GEOM for Solr Indexing
  def solr_geom_mapping
    if send(GEOMG.FIELDS.GEOM).present?
      # "W,S,E,N" convert to "ENVELOPE(W,E,N,S)"
      w, s, e, n = send(GEOMG.FIELDS.GEOM).split(',')
      "ENVELOPE(#{w},#{e},#{n},#{s})"
    else
      ''
    end
  end

  private

  def transition_publication_state
    state_machine.transition_to!(publication_state.downcase) if publication_state_changed?
  end
end
