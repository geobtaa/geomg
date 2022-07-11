# frozen_string_literal: true

require 'rgeo'

# GEOM Validation
#
# Uses RGeo to parse and validate
# POLYGON and MULTIPOLYGON Geom values
class Document
  # GeomValidator
  class GeomValidator < ActiveModel::Validator
    def validate(record)
      # Assume true for empty values
      valid_geom = true

      # Sane GEOM?
      proper_geom(record, valid_geom) if record.send(GEOMG.FIELDS.GEOM).present?

      valid_geom
    end

    # Validates POLYGON and MULTIPOLYGON
    def proper_geom(record, valid_geom)
      geom = record.send(GEOMG.FIELDS.GEOM)
      begin
        valid_geom = if RGeo::Cartesian::Factory.new.parse_wkt(geom)
                       true
                     else
                       false
                     end
      rescue StandardError => e
        valid_geom = false
        record.errors.add(GEOMG.FIELDS.GEOM, "Invalid geometry: #{e}")
      end
      valid_geom
    end
  end
end
