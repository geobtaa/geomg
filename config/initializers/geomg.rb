# frozen_string_literal: true

require "json"

GEOMG_SCHEMA = HashWithIndifferentAccess.new(
  JSON.parse(
    File.read(
      Rails.root.join("config/geomg_aardvark_schema.json")
    )
  )
)

BLACKLIGHT_URL = ENV["BLACKLIGHT_URL"]
BLACKLIGHT_JSON_API = ENV["BLACKLIGHT_JSON_API"]
BLACKLIGHT_JSON_API_IDS = ENV["BLACKLIGHT_JSON_API_IDS"]
BLACKLIGHT_JSON_API_FACETS = ENV["BLACKLIGHT_JSON_API_FACETS"]

GEOMG_SOLR_FIELDS = if Element.table_exists?
  Element.all.map { |elm|
    [
      elm.label.parameterize(separator: "_").to_sym,
      elm.solr_field
    ]
  }.to_h
else
  {}
end
