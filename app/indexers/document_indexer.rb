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
    to_field ::Settings.FIELDS.TITLE, obj_extract('title')
    to_field ::Settings.FIELDS.ALT_TITLE, obj_extract(::Settings.FIELDS.ALT_TITLE)
    to_field ::Settings.FIELDS.DESCRIPTION, obj_extract(::Settings.FIELDS.DESCRIPTION)
    to_field ::Settings.FIELDS.LANGUAGE, obj_extract(::Settings.FIELDS.LANGUAGE)

    # - Credits
    to_field ::Settings.FIELDS.CREATOR, obj_extract(::Settings.FIELDS.CREATOR), transform(->(v) { v.presence ? v : nil })
    to_field ::Settings.FIELDS.PUBLISHER, obj_extract(::Settings.FIELDS.PUBLISHER), transform(->(v) { v.presence ? v : nil })

    # - Categories
    to_field ::Settings.FIELDS.B1G_GENRE, obj_extract(::Settings.FIELDS.B1G_GENRE)
    to_field ::Settings.FIELDS.SUBJECT, obj_extract(::Settings.FIELDS.SUBJECT), transform(->(v) { v.presence ? v : nil })
    to_field ::Settings.FIELDS.B1G_KEYWORD, obj_extract(::Settings.FIELDS.B1G_KEYWORD)
    to_field ::Settings.FIELDS.THEME, obj_extract(::Settings.FIELDS.THEME)

    # - Temporal
    to_field ::Settings.FIELDS.ISSUED, obj_extract(::Settings.FIELDS.ISSUED)
    to_field ::Settings.FIELDS.TEMPORAL, obj_extract(::Settings.FIELDS.TEMPORAL), transform(->(v) { v.presence ? v : nil })
    to_field ::Settings.FIELDS.B1G_DATE_RANGE, obj_extract('date_range_json'), transform(->(v) { v.presence ? v : nil })
    to_field ::Settings.FIELDS.YEAR, obj_extract('solr_year_json'), transform(->(v) { v.presence ? v : nil })

    # - Spatial
    to_field ::Settings.FIELDS.SPATIAL, obj_extract(::Settings.FIELDS.SPATIAL), transform(->(v) { v.presence ? v : nil })
    to_field ::Settings.FIELDS.B1G_GEONAMES, obj_extract(::Settings.FIELDS.B1G_GEONAMES)
    to_field ::Settings.FIELDS.GEOM, obj_extract('solr_geom_mapping')
    to_field ::Settings.FIELDS.B1G_CENTROID, obj_extract(::Settings.FIELDS.B1G_CENTROID)

    # - Relations
    to_field ::Settings.FIELDS.IS_REPLACED_BY, obj_extract(::Settings.FIELDS.IS_REPLACED_BY)
    to_field ::Settings.FIELDS.IS_VERSION_OF, obj_extract(::Settings.FIELDS.IS_VERSION_OF)
    to_field ::Settings.FIELDS.MEMBER_OF, obj_extract(::Settings.FIELDS.MEMBER_OF)
    to_field ::Settings.FIELDS.RELATION, obj_extract(::Settings.FIELDS.RELATION)
    to_field ::Settings.FIELDS.REPLACES, obj_extract(::Settings.FIELDS.REPLACES)

    # Distribution
    # - Object
    to_field ::Settings.FIELDS.LAYER_GEOM_TYPE, obj_extract(::Settings.FIELDS.LAYER_GEOM_TYPE)
    to_field ::Settings.FIELDS.LAYER_ID, obj_extract(::Settings.FIELDS.LAYER_ID)
    to_field ::Settings.FIELDS.FORMAT, obj_extract(::Settings.FIELDS.FORMAT)
    to_field ::Settings.FIELDS.FILE_SIZE, obj_extract(::Settings.FIELDS.FILE_SIZE)

    # - Access Links
    # - Geospatial Web Services
    # - Images
    # - Metadata
    to_field ::Settings.FIELDS.GEOREFERENCED, obj_extract(::Settings.FIELDS.GEOREFERENCED)
    to_field ::Settings.FIELDS.REFERENCES, obj_extract('references_json')
    to_field ::Settings.FIELDS.B1G_IMAGE, obj_extract(::Settings.FIELDS.B1G_IMAGE)
    to_field 'b1g_access_s', obj_extract('access_json')

    # Administrative
    # - Codes
    to_field ::Settings.FIELDS.IDENTIFIER, obj_extract(::Settings.FIELDS.IDENTIFIER)
    to_field ::Settings.FIELDS.LAYER_SLUG, obj_extract(::Settings.FIELDS.LAYER_SLUG)
    to_field ::Settings.FIELDS.PROVENANCE, obj_extract(::Settings.FIELDS.PROVENANCE)
    to_field ::Settings.FIELDS.B1G_CODE, obj_extract(::Settings.FIELDS.B1G_CODE)
    to_field ::Settings.FIELDS.IS_PART_OF, obj_extract(::Settings.FIELDS.IS_PART_OF)
    to_field ::Settings.FIELDS.SOURCE, obj_extract(::Settings.FIELDS.SOURCE)

    # - Rights
    to_field ::Settings.FIELDS.LICENSE, obj_extract(::Settings.FIELDS.LICENSE)

    # - Status
    to_field ::Settings.FIELDS.B1G_STATUS, obj_extract(::Settings.FIELDS.B1G_STATUS)
    to_field ::Settings.FIELDS.B1G_ACCRUAL_METHOD, obj_extract(::Settings.FIELDS.B1G_ACCRUAL_METHOD)
    to_field ::Settings.FIELDS.B1G_ACCRUAL_PERIODICITY, obj_extract(::Settings.FIELDS.B1G_ACCRUAL_PERIODICITY)
    to_field ::Settings.FIELDS.B1G_DATE_ACCESSIONED, obj_extract(::Settings.FIELDS.B1G_DATE_ACCESSIONED)
    to_field ::Settings.FIELDS.B1G_DATE_RETIRED, obj_extract(::Settings.FIELDS.B1G_DATE_RETIRED)
    to_field 'b1g_publication_state_s', obj_extract('current_state')

    # - Accessibility
    to_field ::Settings.FIELDS.RIGHTS, obj_extract(::Settings.FIELDS.RIGHTS)
    to_field ::Settings.FIELDS.RIGHTS_HOLDER, obj_extract(::Settings.FIELDS.RIGHTS_HOLDER)
    to_field ::Settings.FIELDS.ACCESS_RIGHTS, obj_extract(::Settings.FIELDS.ACCESS_RIGHTS), transform(->(v) { v.presence ? v : nil })
    to_field ::Settings.FIELDS.SUPPRESSED, obj_extract(::Settings.FIELDS.SUPPRESSED)
    to_field ::Settings.FIELDS.B1G_CHILD_RECORD, obj_extract(::Settings.FIELDS.B1G_CHILD_RECORD)
    to_field ::Settings.FIELDS.B1G_MEDIATOR, obj_extract(::Settings.FIELDS.B1G_MEDIATOR)

    to_field 'gbl_mdModified_dt', obj_extract('gbl_mdModified_dt')

    # May want to switch to or add a 'date published' instead, right
    # now we only have date added to DB, which is what we had in sufia.
    to_field 'date_created_dtsi' do |rec, acc|
      acc << rec.created_at.utc.iso8601 if rec.created_at
    end

    to_field 'date_modified_dtsi' do |rec, acc|
      acc << rec.updated_at.utc.iso8601 if rec.updated_at
    end

    # - Settings
    to_field 'b1g_geom_import_id_ssi', obj_extract('import_id')
  end
end
