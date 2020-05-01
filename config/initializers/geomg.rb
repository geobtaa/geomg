require 'json'

GEOMG_SCHEMA = HashWithIndifferentAccess.new(
  JSON.parse(
    File.read(
      "#{Rails.root.to_s}/config/schema.json"
    )
  )
)
