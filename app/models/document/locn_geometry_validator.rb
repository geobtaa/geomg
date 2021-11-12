# frozen_string_literal: true

# Locn Geometry Validation
#
# ex. Bad X value
# -100096.7909 is not in boundary
# Rect(minX=-180.0,maxX=180.0,minY=-90.0,maxY=90.0)
# input: ENVELOPE(-100096.7909,-90.0574,43.9474,39.9655)
class Document
  # LocnGeometryValidator
  class LocnGeometryValidator < ActiveModel::Validator
    def validate(record)
      # Assume true for empty values
      valid_geom = true

      # Sane for W,S,E,N?
      proper_bounding_box(record, valid_geom) unless record.send(GEOMG.FIELDS.GEOM).nil?

      valid_geom
    end

    def proper_bounding_box(record, valid_geom)
      # Min/Max
      min_max = [-180.0, -90.0, 180.0, 90.0]

      # "W,S,E,N" to [W,S,E,N]
      unless record.send(GEOMG.FIELDS.GEOM).split(',').nil?
        geom = record.send(GEOMG.FIELDS.GEOM).split(',')
        if geom.empty?
          valid_geom = true
        elsif geom.size != 4
          valid_geom = false
          record.errors.add(GEOMG.FIELDS.GEOM, 'invalid W,S,E,N syntax')
        # W
        elsif geom[0].to_f < min_max[0]
          valid_geom = false
          record.errors.add(GEOMG.FIELDS.GEOM, 'invalid minX present')
        # S
        elsif geom[1].to_f < min_max[1]
          valid_geom = false
          record.errors.add(GEOMG.FIELDS.GEOM, 'invalid minY present')
        # E
        elsif geom[2].to_f > min_max[2]
          valid_geom = false
          record.errors.add(GEOMG.FIELDS.GEOM, 'invalid maX present')
        # N
        elsif geom[3].to_f > min_max[3]
          valid_geom = false
          record.errors.add(GEOMG.FIELDS.GEOM, 'invalid maxY present')
        # Solr - maxY must be >= minY
        elsif geom[1].to_f >= geom[3].to_f
          valid_geom = false
          record.errors.add(GEOMG.FIELDS.GEOM, 'maxY must be >= minY')
        end
      end
      valid_geom
    end
  end
end
