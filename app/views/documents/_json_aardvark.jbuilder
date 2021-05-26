# frozen_string_literal: true

# See GBL Aardvark Schema
# https://docs.google.com/spreadsheets/d/1QQjUzRe8YdPGKK4h0GYoNPTow2zZ1f0KFA0zzZyHAsk/edit?ts=602d52f2#gid=252925024

# Schema
json.dct_title_s          document.send(GEOMG.FIELDS.TITLE)
json.dct_alternative_sm   document.send(GEOMG.FIELDS.ALT_TITLE)
json.dct_description_sm   document.send(GEOMG.FIELDS.DESCRIPTION)
json.dct_language_sm      document.send(GEOMG.FIELDS.LANGUAGE)
json.dct_creator_sm       document.send(GEOMG.FIELDS.CREATOR)
json.dct_publisher_sm     document.send(GEOMG.FIELDS.PUBLISHER)
json.schema_provider_s    document.send(GEOMG.FIELDS.PROVENANCE)
json.gbl_resourceClass_sm document.send(GEOMG.FIELDS.B1G_GENRE)
json.gbl_resourceType_sm  document.send(GEOMG.FIELDS.LAYER_GEOM_TYPE)
json.dct_subject_sm       document.send(GEOMG.FIELDS.SUBJECT)
json.dcat_theme_sm        document.send(GEOMG.FIELDS.THEME)
json.dcat_keyword_sm      document.send(GEOMG.FIELDS.B1G_KEYWORD)
json.dct_temporal_sm      document.send(GEOMG.FIELDS.TEMPORAL)
json.dct_issued_s         document.send(GEOMG.FIELDS.ISSUED)
json.gbl_indexYear_im     document.send(GEOMG.FIELDS.YEAR)
json.gbl_dateRange_drsim  document.date_range_json
json.dct_spatial_sm       document.send(GEOMG.FIELDS.SPATIAL)
json.locn_geometry        document.solr_geom_mapping
json.dcat_centroid_ss     document.send(GEOMG.FIELDS.B1G_CENTROID)
json.dct_relation_sm      document.send(GEOMG.FIELDS.RELATION)
json.pcdm_memberOf_sm     document.send(GEOMG.FIELDS.MEMBER_OF)
json.dct_isPartOf_sm      document.send(GEOMG.FIELDS.IS_PART_OF)
json.dct_source_sm        document.send(GEOMG.FIELDS.SOURCE)
json.dct_isVersionOf_sm   document.send(GEOMG.FIELDS.IS_VERSION_OF)
json.dct_replaces_sm      document.send(GEOMG.FIELDS.REPLACES)
json.dct_isReplacedBy_sm  document.send(GEOMG.FIELDS.IS_REPLACED_BY)
json.dct_rights_sm        document.send(GEOMG.FIELDS.RIGHTS)
json.dct_rightsHolder_sm  document.send(GEOMG.FIELDS.RIGHTS_HOLDER)
json.dct_license_sm       document.send(GEOMG.FIELDS.LICENSE)
json.dct_accessRights_s   document.send(GEOMG.FIELDS.ACCESS_RIGHTS)
json.dct_format_s         document.send(GEOMG.FIELDS.FORMAT)
json.gbl_fileSize_s       document.send(GEOMG.FIELDS.FILE_SIZE)
json.gbl_wxsIdentifier_s  document.send(GEOMG.FIELDS.LAYER_ID)
json.dct_references_s     document.references_json
json.id                   document.send(GEOMG.FIELDS.LAYER_SLUG)
json.dct_identifier_sm    document.send(GEOMG.FIELDS.IDENTIFIER)
json.gbl_mdModified_dt    document.send(GEOMG.FIELDS.LAYER_MODIFIED)
json.gbl_mdVersion_s      'Aardvark'
json.gbl_suppressed_b     document.send(GEOMG.FIELDS.SUPPRESSED)
json.gbl_georeferenced_b  document.send(GEOMG.FIELDS.GEOREFERENCED)
