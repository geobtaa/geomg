# frozen_string_literal: true

# See GBL Wiki
# https://github.com/geoblacklight/geoblacklight/wiki/GeoBlacklight-1.0-Metadata-Elements

# Required
json.geoblacklight_version '1.0'
json.dc_identifier_s    document.dc_identifier_s
json.dc_rights_s        document.dc_rights_s
json.dc_title_s         document.title
json.dct_provenance_s   document.dct_provenance_s
json.layer_slug_s       document.layer_slug_s
json.solr_geom          document.solr_geom

# Recommended
json.solr_year_i        document.solr_year_i
json.dc_creator_sm      document.dc_creator_sm
json.dc_description_s   document.dc_description_s
json.dc_format_s        document.dc_format_s
json.dc_subject_sm      document.dc_subject_sm
json.dct_references_s   document.references_json
json.b1g_access_s       document.access_json
json.dct_spatial_sm     document.dct_spatial_sm
json.layer_geom_type_s  document.layer_geom_type_s
json.layer_modified_dt  document.layer_modified_dt

# Optional
json.dc_language_sm     document.dc_language_sm
json.dc_publisher_s     document.dc_publisher_sm
# json.dc_source_sm     document.dc_source_sm             @TODO: Add Support
json.dc_type_s          document.dc_type_sm
json.dct_isPartOf_sm    document.dct_isPartOf_sm
json.dct_issued_s       document.dct_issued_s
json.dct_temporal_sm    document.dct_temporal_sm
# json.layer_id_s       document.layer_id_s               @TODO: Add Support
json.suppressed_b       document.suppressed_b
