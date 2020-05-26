require 'json'

GEOMG_SCHEMA = HashWithIndifferentAccess.new(
  JSON.parse(
    File.read(
      "#{Rails.root.to_s}/config/schema.json"
    )
  )
)

BLACKLIGHT_URL = 'http://localhost:3001'
BLACKLIGHT_JSON_API = 'http://localhost:3001/catalog.json'
