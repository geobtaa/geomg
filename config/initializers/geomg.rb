# frozen_string_literal: true

require 'json'

GEOMG_SCHEMA = HashWithIndifferentAccess.new(
  JSON.parse(
    File.read(
      Rails.root.join('config/schema.json')
    )
  )
)

BLACKLIGHT_URL = ENV['BLACKLIGHT_URL']
BLACKLIGHT_JSON_API = ENV['BLACKLIGHT_JSON_API']
