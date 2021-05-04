# frozen_string_literal: true
Config.setup do |config|
  config.const_name = 'GEOMG'
end

# GeoBlacklight v3.3 - New Settings.FIELDS values
GEOMG.prepend_source!(File.expand_path('new_gbl_settings_defaults_3_3.yml', __dir__))
GEOMG.reload!
