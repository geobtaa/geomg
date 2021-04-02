# frozen_string_literal: true

# Solr indexing for our document class. Still a work in progress.
class DocumentIndexer < Kithe::Indexer
  configure do
    # Kithe
    to_field 'model_pk_ssi', obj_extract('id') # the actual db pk, a UUID

    # GeoBlacklight
    to_field 'gbl_mdVersion_s', literal('Aardvark')

    # Form
    # Identification
    # - Descriptive
    to_field GEOMG.FIELDS.TITLE, obj_extract('title')
    to_field GEOMG.FIELDS.ALT_TITLE, obj_extract(GEOMG.FIELDS.ALT_TITLE)
    to_field GEOMG.FIELDS.DESCRIPTION, obj_extract(GEOMG.FIELDS.DESCRIPTION)
    to_field GEOMG.FIELDS.LANGUAGE, obj_extract(GEOMG.FIELDS.LANGUAGE)

    # - Credits
    to_field GEOMG.FIELDS.CREATOR, obj_extract(GEOMG.FIELDS.CREATOR), transform(->(v) { v.presence ? v : nil })
    to_field GEOMG.FIELDS.PUBLISHER, obj_extract(GEOMG.FIELDS.PUBLISHER), transform(->(v) { v.presence ? v : nil })

    # - Categories
    to_field GEOMG.FIELDS.B1G_GENRE, obj_extract(GEOMG.FIELDS.B1G_GENRE)
    to_field GEOMG.FIELDS.SUBJECT, obj_extract(GEOMG.FIELDS.SUBJECT), transform(->(v) { v.presence ? v : nil })
    to_field GEOMG.FIELDS.B1G_KEYWORD, obj_extract(GEOMG.FIELDS.B1G_KEYWORD)

    # - Temporal
    to_field GEOMG.FIELDS.ISSUED, obj_extract(GEOMG.FIELDS.ISSUED)
    to_field GEOMG.FIELDS.TEMPORAL, obj_extract(GEOMG.FIELDS.TEMPORAL), transform(->(v) { v.presence ? v : nil })
    to_field GEOMG.FIELDS.B1G_DATE_RANGE, obj_extract('date_range_json'), transform(->(v) { v.presence ? v : nil })
    to_field GEOMG.FIELDS.YEAR, obj_extract('solr_year_json'), transform(->(v) { v.presence ? v : nil })

    # - Spatial
    to_field GEOMG.FIELDS.SPATIAL, obj_extract(GEOMG.FIELDS.SPATIAL), transform(->(v) { v.presence ? v : nil })
    to_field GEOMG.FIELDS.B1G_GEONAMES, obj_extract(GEOMG.FIELDS.B1G_GEONAMES)
    to_field GEOMG.FIELDS.GEOM, obj_extract(GEOMG.FIELDS.GEOM), transform(->(v) { v.presence ? v : nil })
    to_field GEOMG.FIELDS.B1G_CENTROID, obj_extract(GEOMG.FIELDS.B1G_CENTROID)

    # Distribution
    # - Object
    to_field GEOMG.FIELDS.TYPE, obj_extract(GEOMG.FIELDS.TYPE)
    to_field GEOMG.FIELDS.LAYER_GEOM_TYPE, obj_extract(GEOMG.FIELDS.LAYER_GEOM_TYPE)
    to_field GEOMG.FIELDS.LAYER_ID, obj_extract(GEOMG.FIELDS.LAYER_ID)
    to_field GEOMG.FIELDS.FORMAT, obj_extract(GEOMG.FIELDS.FORMAT)

    # - Access Links
    # - Geospatial Web Services
    # - Images
    # - Metadata
    to_field GEOMG.FIELDS.REFERENCES, obj_extract('references_json')
    to_field GEOMG.FIELDS.B1G_IMAGE, obj_extract(GEOMG.FIELDS.B1G_IMAGE)
    to_field 'b1g_access_s', obj_extract('access_json')

    # Administrative
    # - Codes
    to_field GEOMG.FIELDS.IDENTIFIER, obj_extract(GEOMG.FIELDS.IDENTIFIER)
    to_field GEOMG.FIELDS.LAYER_SLUG, obj_extract(GEOMG.FIELDS.LAYER_SLUG)
    to_field GEOMG.FIELDS.PROVENANCE, obj_extract(GEOMG.FIELDS.PROVENANCE)
    to_field GEOMG.FIELDS.B1G_CODE, obj_extract(GEOMG.FIELDS.B1G_CODE)
    to_field GEOMG.FIELDS.IS_PART_OF, obj_extract(GEOMG.FIELDS.IS_PART_OF)
    to_field GEOMG.FIELDS.SOURCE, obj_extract(GEOMG.FIELDS.SOURCE)

    # - Status
    to_field GEOMG.FIELDS.B1G_STATUS, obj_extract(GEOMG.FIELDS.B1G_STATUS)
    to_field GEOMG.FIELDS.B1G_ACCRUAL_METHOD, obj_extract(GEOMG.FIELDS.B1G_ACCRUAL_METHOD)
    to_field GEOMG.FIELDS.B1G_ACCRUAL_PERIODICITY, obj_extract(GEOMG.FIELDS.B1G_ACCRUAL_PERIODICITY)
    to_field GEOMG.FIELDS.B1G_DATE_ACCESSIONED, obj_extract(GEOMG.FIELDS.B1G_DATE_ACCESSIONED)
    to_field GEOMG.FIELDS.B1G_DATE_RETIRED, obj_extract(GEOMG.FIELDS.B1G_DATE_RETIRED)
    to_field 'b1g_publication_state_s', obj_extract('current_state')

    # - Accessibility
    to_field GEOMG.FIELDS.RIGHTS, obj_extract(GEOMG.FIELDS.RIGHTS)
    to_field GEOMG.FIELDS.ACCESS_RIGHTS, obj_extract(GEOMG.FIELDS.ACCESS_RIGHTS), transform(->(v) { v.presence ? v : nil })
    to_field GEOMG.FIELDS.SUPPRESSED, obj_extract(GEOMG.FIELDS.SUPPRESSED)
    to_field GEOMG.FIELDS.B1G_CHILD_RECORD, obj_extract(GEOMG.FIELDS.B1G_CHILD_RECORD)

    to_field 'layer_modified_dt', obj_extract('layer_modified_dt')

    # May want to switch to or add a 'date published' instead, right
    # now we only have date added to DB, which is what we had in sufia.
    to_field 'date_created_dtsi' do |rec, acc|
      acc << rec.created_at.utc.iso8601 if rec.created_at
    end

    to_field 'date_modified_dtsi' do |rec, acc|
      acc << rec.updated_at.utc.iso8601 if rec.updated_at
    end

    # - GEOMG
    to_field 'b1g_geom_import_id_ssi', obj_extract('import_id')
  end
end
