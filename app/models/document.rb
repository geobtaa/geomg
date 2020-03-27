class Document < Kithe::Work
  has_paper_trail

  # Indexer
  self.kithe_indexable_mapper = DocumentIndexer.new

  # Validations
  validates :b1g_status_s, presence: true
  validates :dc_identifier_s, presence: true
  validates :dc_format_s, presence: true
  validates :dc_rights_s, presence: true
  validates :layer_geom_type_s, presence: true
  validates :layer_slug_s, presence: true

  # Form
  # Identification
  # - Descriptive
  # attr_json :dc_title_s, :string - Comes from Kithe "title"
  attr_json :dct_alternativeTitle_sm, :string, array: true, default: -> { [] }
  attr_json :dc_description_s, :text
  attr_json :dc_language_sm, :string, array: true, default: -> { [] }

  # - Credits
  attr_json :dc_creator_sm, :string, array: true, default: -> { [] }
  attr_json :dc_publisher_sm, :string, array: true, default: -> { [] }

  # - Categories
  attr_json :b1g_genre_sm, :string, array: true, default: -> { [] }
  attr_json :dc_subject_sm, :string, array: true, default: -> { [] }
  attr_json :b1g_keyword_sm, :string, array: true, default: -> { [] }

  # - Temporal
  attr_json :dct_issued_s, :string
  attr_json :dct_temporal_sm, :string, array: true, default: -> { [] }
  attr_json :b1g_date_range_drsim, :string, array: true, default: -> { [] }
  attr_json :solr_year_i, :integer

  # - Spatial
  attr_json :dct_spatial_sm, :string, array: true, default: -> { [] }
  attr_json :b1g_geonames_sm, :string, array: true, default: -> { [] }
  attr_json :solr_geom, :string
  attr_json :b1g_centroid_ss, :string

  # Distribution
  # - Object
  attr_json :dc_type_sm, :string, array: true, default: -> { [] }
  attr_json :layer_geom_type_s, :string
  attr_json :dc_format_s, :string

  # - Access Links
  # - Geospatial Web Services
  # - Images
  # - Metadata
  attr_json :dct_references_s, Document::Reference.to_type, array: true, default: -> { [] }
  attr_json :b1g_image_ss, :string

  # Administrative
  # - Codes
  attr_json :dc_identifier_s, :string
  attr_json :layer_slug_s, :string
  attr_json :dct_provenance_s, :string
  attr_json :b1g_code_s, :string
  attr_json :dct_isPartOf_sm, :string, array: true, default: -> { [] }

  # - Status
  attr_json :b1g_status_s, :string
  attr_json :dct_accrualMethod_s, :string
  attr_json :dct_accrualPeriodicity_s, :string
  attr_json :b1g_dateAccessioned_s, :string
  attr_json :b1g_dateRetired_s, :string

  # - Accessibility
  attr_json :dc_rights_s, :string

  # @TODO: Why are booleans not passed in form params?
  attr_json :suppressed_b, :boolean
  attr_json :b1g_child_record_b, :boolean

  # Transformations
  def references_json
    references = Hash.new
    self.dct_references_s.each{ |ref| references[Document::Reference.lookup(ref.category)] = ref.value }
    references.to_json
  end
end
