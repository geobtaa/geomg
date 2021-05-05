# frozen_string_literal: true

# See GBL Wiki
# https://github.com/geoblacklight/geoblacklight/wiki/GeoBlacklight-1.0-Metadata-Elements

# Required
json.geoblacklight_version '1.0'
json.dc_identifier_s    document.send(Settings.FIELDS.IDENTIFIER)
json.dc_rights_s        document.send(Settings.FIELDS.RIGHTS)
json.dc_title_s         document.send(Settings.FIELDS.TITLE)
json.dct_provenance_s   document.send(Settings.FIELDS.PROVENANCE)
json.layer_slug_s       document.send(Settings.FIELDS.LAYER_SLUG)
json.solr_geom          document.send(Settings.FIELDS.GEOM)

# Recommended
json.solr_year_i        document.send(Settings.FIELDS.YEAR)
json.dc_creator_sm      document.send(Settings.FIELDS.CREATOR)
json.dc_description_s   document.send(Settings.FIELDS.DESCRIPTION)
json.dc_format_s        document.send(Settings.FIELDS.FORMAT)
json.dc_subject_sm      document.send(Settings.FIELDS.SUBJECT)
json.dct_references_s   document.references_json
json.b1g_access_s       document.access_json
json.dct_spatial_sm     document.send(Settings.FIELDS.SPATIAL)
json.layer_geom_type_s  document.send(Settings.FIELDS.LAYER_GEOM_TYPE)
json.layer_modified_dt  document.send(Settings.FIELDS.LAYER_MODIFIED)

# Optional
json.dc_language_sm     document.send(Settings.FIELDS.LANGUAGE)
json.dc_publisher_s     document.send(Settings.FIELDS.PUBLISHER)
json.dc_source_sm       document.send(Settings.FIELDS.SOURCE)
json.dct_isPartOf_sm    document.send(Settings.FIELDS.IS_PART_OF)
json.dct_issued_s       document.send(Settings.FIELDS.ISSUED)
json.dct_temporal_sm    document.send(Settings.FIELDS.TEMPORAL)
json.layer_id_s         document.send(Settings.FIELDS.LAYER_ID)
json.suppressed_b       document.send(Settings.FIELDS.SUPPRESSED)
