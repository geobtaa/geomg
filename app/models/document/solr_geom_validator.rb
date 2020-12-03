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
      unless record.solr_geom.nil?
        valid_geom = starts_with_envelope(record, valid_geom)
        valid_geom = ends_with_parenthesis(record, valid_geom)
        proper_bounding_box(record, valid_geom)
      end

      valid_geom
    end

    def starts_with_envelope(record, valid_geom)
      unless record.solr_geom.start_with?('ENVELOPE(')
        valid_geom = false
        record.errors.add(:solr_geom, 'Incorrect ENVELOPE() wrapper')
      end
      valid_geom
    end

    def ends_with_parenthesis(record, valid_geom)
      unless record.solr_geom.end_with?(')')
        valid_geom = false
        record.errors.add(:solr_geom, 'Incorrect ENVELOPE() wrapper')
      end
      valid_geom
    end

    def proper_bounding_box(record, valid_geom)
      # Min/Max
      min_max = [-180.0, 180.0, -90.0, 90.0]

      unless record.solr_geom.match(/\((.*?)\)/).nil?
        geom = record.solr_geom.match(/\((.*?)\)/)[1].split(',')
        if geom.empty?
          valid_geom = true
        elsif geom[0].to_f < min_max[0]
          valid_geom = false
          record.errors.add(:solr_geom, 'invalid minX present')
        elsif geom[1].to_f > min_max[1]
          valid_geom = false
          record.errors.add(:solr_geom, 'invalid maX present')
        elsif geom[2].to_f < min_max[2]
          valid_geom = false
          record.errors.add(:solr_geom, 'invalid minY present')
        elsif geom[3].to_f > min_max[3]
          valid_geom = false
          record.errors.add(:solr_geom, 'invalid maxY present')
        end
      end
      valid_geom
    end
  end
end
