class Document < Kithe::Work
  # Indexer
  self.kithe_indexable_mapper = DocumentIndexer.new

  # Validations
  validates :layer_slug_s, presence: true

  # GeoBlacklight Attributes
  attr_json :dc_description_s, :text
  attr_json :dc_format_s, :string
  attr_json :dc_identifier_s, :string
  attr_json :dc_language_sm, :string, array: true, default: -> { [] }
  attr_json :dc_rights_s, :string
  # attr_json :dc_title_s, :string - Kithe "title"
  attr_json :dc_type_sm, :string, array: true, default: -> { [] }
  attr_json :dct_isPartOf_sm, :string, array: true, default: -> { [] }
  attr_json :dct_provenance_s, :string
  attr_json :dct_references_s, Document::Reference.to_type, array: true, default: -> { [] }
  attr_json :dct_spatial_sm, :string, array: true, default: -> { [] }
  attr_json :dct_temporal_sm, :string, array: true, default: -> { [] }
  attr_json :layer_geom_type_s, :string
  attr_json :layer_slug_s, :string
  attr_json :solr_geom, :string
  attr_json :solr_year_i, :integer

  # B1G Attributes
  attr_json :b1g_centroid_ss, :string
  attr_json :b1g_code_s, :string
  attr_json :b1g_dateAccessioned_s, :string
  attr_json :b1g_date_range_drsim, :string, array: true, default: -> { [] }
  attr_json :b1g_genre_sm, :string, array: true, default: -> { [] }
  attr_json :b1g_image_ss, :string
  attr_json :b1g_keyword_sm, :string, array: true, default: -> { [] }
  attr_json :b1g_status_s, :string

  # Transformations
  def references_json
    references = Hash.new
    self.dct_references_s.each{|ref| references[ref.category] = ref.value }
    references.to_json
  end
end
