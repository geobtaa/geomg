# frozen_string_literal: true

# Solr Geom Validation
#
# ex. Bad X value
# -100096.7909 is not in boundary
# Rect(minX=-180.0,maxX=180.0,minY=-90.0,maxY=90.0)
# input: ENVELOPE(-100096.7909,-90.0574,43.9474,39.9655)
class Document
  # Solr Geom Validator
  class SolrGeomValidator < ActiveModel::Validator
    def validate(record)
      # Assume true for empty values
      valid_geom = true

      # Sane for Solr?
      proper_bounding_box(record, valid_geom) unless record.send(Settings.FIELDS.GEOM).nil?

      valid_geom
    end

    def proper_bounding_box(record, valid_geom)
      # Min/Max
      min_max = [-180.0, -90.0, 180.0, 90.0]

      # (W,E,N,S) to "W,S,E,N"
      unless record.send(Settings.FIELDS.GEOM).split(',').nil?
        geom = record.send(Settings.FIELDS.GEOM).split(',')
        if geom.empty?
          valid_geom = true
        elsif geom[0].to_f < min_max[0]
          # W
          valid_geom = false
          record.errors.add(Settings.FIELDS.GEOM, 'invalid minX present')
        elsif geom[1].to_f < min_max[1]
          # S
          valid_geom = false
          record.errors.add(Settings.FIELDS.GEOM, 'invalid minY present')
        elsif geom[2].to_f > min_max[2]
          # E
          valid_geom = false
          record.errors.add(Settings.FIELDS.GEOM, 'invalid maX present')
        elsif geom[3].to_f > min_max[3]
          # N
          valid_geom = false
          record.errors.add(Settings.FIELDS.GEOM, 'invalid maxY present')
        end
      end
      valid_geom
    end
  end
end
