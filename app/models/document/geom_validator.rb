# frozen_string_literal: true

require 'rgeo'

# GEOM Validation
#
# Uses local logic to parse and validate ENVELOPE values
# Uses RGeo to parse and validate POLYGON or MULTIPOLYGON values
class Document
  # GeomValidator
  class GeomValidator < ActiveModel::Validator
    def validate(record)
      # Assume true for empty values
      valid_geom = true

      if record.send(GEOMG.FIELDS.GEOM).present?
        if record.send(GEOMG.FIELDS.GEOM).start_with?("ENVELOPE")
          # Sane ENVELOPE?
          valid_geom = proper_envelope(record, valid_geom)
        else
          # Sane GEOM?
          valid_geom = proper_geom(record, valid_geom)
        end
      end

      valid_geom
    end

    # Validates ENVELOPE
    def proper_envelope(record, valid_geom)
      geom = record.send(GEOMG.FIELDS.GEOM)
      begin
        valid_geom, error_message = valid_bbox?(geom.delete("ENVELOPE()"))
      rescue StandardError => e
        valid_geom = false
        record.errors.add(GEOMG.FIELDS.GEOM, "Invalid envelope: #{e}")
      end

      if !valid_geom
        record.errors.add(GEOMG.FIELDS.GEOM, "Invalid envelope: #{error_message}")
      end

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

      # Guard against a whole world polygons
      if geom == 'POLYGON((-180 90, 180 90, 180 -90, -180 -90, -180 90))'
        valid_geom = false
        record.errors.add(GEOMG.FIELDS.GEOM, "Invalid polygon: all points are coplanar input, Solr will not index")
      end

      valid_geom
    end

    def valid_bbox?(bbox)
      # Default to true
      valid_bbox = true
      error_message = ''

      # Min/Max
      min_max = [-180.0, -90.0, 180.0, 90.0]
      bbox = bbox.split(',')

      # @TODO: Essentially duplicated logic from bbox_validator.rb, DRY it up
      if bbox.size != 4
        valid_bbox = false
        error_message = 'invalid W,S,E,N syntax'
      # W
      elsif bbox[0].to_f < min_max[0]
        valid_bbox = false
        error_message = 'invalid minX present'
      # S
      elsif bbox[1].to_f < min_max[1]
        valid_bbox = false
        error_message = 'invalid minY present'
      # E
      elsif bbox[2].to_f > min_max[2]
        valid_bbox = false
        error_message = 'invalid maX present'
      # N
      elsif bbox[3].to_f > min_max[3]
        valid_bbox = false
        error_message = 'invalid maxY present'
      # Solr - maxY must be >= minY
      elsif bbox[1].to_f >= bbox[3].to_f
        valid_bbox = false
        error_message = 'maxY must be >= minY'
      end

      return valid_bbox, error_message
    end
  end
end
