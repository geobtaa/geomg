# frozen_string_literal: true

# See OpenGeoMetadata Legacy Versions
# https://opengeometadata.org/docs/gbl-1.0

# Required
json.geoblacklight_version '1.0'
json.dc_identifier_s    no_json_blanks document.send(GEOMG.FIELDS.IDENTIFIER).join('|')
json.dc_rights_s        no_json_blanks document.send(GEOMG.FIELDS.ACCESS_RIGHTS)
json.dc_title_s         no_json_blanks document.send(GEOMG.FIELDS.TITLE)
json.dct_provenance_s   no_json_blanks document.send(GEOMG.FIELDS.PROVENANCE)
json.layer_slug_s       no_json_blanks document.send(GEOMG.FIELDS.LAYER_SLUG)
json.solr_geom          no_json_blanks document.derive_dcat_bbox

# Recommended
json.solr_year_i        no_json_blanks document.send(GEOMG.FIELDS.YEAR)&.first
json.dc_creator_sm      no_json_blanks document.send(GEOMG.FIELDS.CREATOR)
json.dc_description_s   no_json_blanks document.send(GEOMG.FIELDS.DESCRIPTION).join('|')
json.dc_format_s        no_json_blanks document.send(GEOMG.FIELDS.FORMAT)
json.dc_subject_sm      no_json_blanks document.send(GEOMG.FIELDS.SUBJECT)
json.dct_references_s   no_json_blanks document.references_json
json.dct_spatial_sm     no_json_blanks document.send(GEOMG.FIELDS.SPATIAL)
json.layer_modified_dt  no_json_blanks document.send(GEOMG.FIELDS.LAYER_MODIFIED)

# Optional
json.dc_language_sm     no_json_blanks document.send(GEOMG.FIELDS.LANGUAGE)
json.dc_publisher_s     no_json_blanks document.send(GEOMG.FIELDS.PUBLISHER).join('|')
json.dc_source_sm       no_json_blanks document.send(GEOMG.FIELDS.SOURCE)
json.dct_issued_s       no_json_blanks document.send(GEOMG.FIELDS.ISSUED)
json.dct_temporal_sm    no_json_blanks document.send(GEOMG.FIELDS.TEMPORAL)
json.layer_id_s         no_json_blanks document.send(GEOMG.FIELDS.LAYER_ID)
json.suppressed_b       no_json_blanks document.send(GEOMG.FIELDS.SUPPRESSED)
