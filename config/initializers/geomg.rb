require 'json'

GEOMG_SCHEMA = HashWithIndifferentAccess.new(
  JSON.parse(
    File.read(
      "#{Rails.root.to_s}/config/schema.json"
    )
  )
)

BLACKLIGHT_URL = ENV['BLACKLIGHT_URL']
BLACKLIGHT_JSON_API = ENV['BLACKLIGHT_JSON_API']
