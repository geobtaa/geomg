# frozen_string_literal: true

# See OpenGeoMetadata Legacy Versions
# https://opengeometadata.org/docs/gbl-1.0

# Required
json.geoblacklight_version '1.0'
json.dc_identifier_s    no_json_blanks document.send(GEOMG_SOLR_FIELDS[:identifier]).join('|')
json.dc_rights_s        no_json_blanks document.send(GEOMG_SOLR_FIELDS[:access_rights])
json.dc_title_s         no_json_blanks document.send(GEOMG_SOLR_FIELDS[:title])
json.dct_provenance_s   no_json_blanks document.send(GEOMG_SOLR_FIELDS[:provider])
json.layer_slug_s       no_json_blanks document.send(GEOMG_SOLR_FIELDS[:id])
json.solr_geom          no_json_blanks document.derive_dcat_bbox

# Recommended
json.solr_year_i        no_json_blanks document.send(GEOMG_SOLR_FIELDS[:index_year])&.first
json.dc_creator_sm      no_json_blanks document.send(GEOMG_SOLR_FIELDS[:creator])
json.dc_description_s   no_json_blanks document.send(GEOMG_SOLR_FIELDS[:description]).join('|')
json.dc_format_s        no_json_blanks document.send(GEOMG_SOLR_FIELDS[:format])
json.dc_subject_sm      no_json_blanks document.send(GEOMG_SOLR_FIELDS[:subject])
json.dct_references_s   no_json_blanks document.references_json
json.dct_spatial_sm     no_json_blanks document.send(GEOMG_SOLR_FIELDS[:spatial_coverage])
json.layer_modified_dt  no_json_blanks document.send(GEOMG_SOLR_FIELDS[:updated_at])

# Optional
json.dc_language_sm     no_json_blanks document.send(GEOMG_SOLR_FIELDS[:language])
json.dc_publisher_s     no_json_blanks document.send(GEOMG_SOLR_FIELDS[:publisher]).join('|')
json.dc_source_sm       no_json_blanks document.send(GEOMG_SOLR_FIELDS[:source])
json.dct_issued_s       no_json_blanks document.send(GEOMG_SOLR_FIELDS[:date_issued])
json.dct_temporal_sm    no_json_blanks document.send(GEOMG_SOLR_FIELDS[:temporal_coverage])
json.layer_id_s         no_json_blanks document.send(GEOMG_SOLR_FIELDS[:wxs_identifier])
json.suppressed_b       no_json_blanks document.send(GEOMG_SOLR_FIELDS[:suppressed_record])
