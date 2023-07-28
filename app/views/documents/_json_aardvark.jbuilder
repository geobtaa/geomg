# frozen_string_literal: true

# See GBL Aardvark Schema
# https://docs.google.com/spreadsheets/d/1QQjUzRe8YdPGKK4h0GYoNPTow2zZ1f0KFA0zzZyHAsk/edit?ts=602d52f2#gid=252925024

# Schema
json.dct_title_s          no_json_blanks document.send(GEOMG.FIELDS.TITLE)
json.dct_alternative_sm   no_json_blanks document.send(GEOMG.FIELDS.ALT_TITLE)
json.dct_description_sm   no_json_blanks document.send(GEOMG.FIELDS.DESCRIPTION)
json.gbl_displayNote_sm   no_json_blanks document.send(GEOMG.FIELDS.DISPLAY_NOTE)
json.dct_language_sm      no_json_blanks document.send(GEOMG.FIELDS.LANGUAGE)
json.dct_creator_sm       no_json_blanks document.send(GEOMG.FIELDS.CREATOR)
json.dct_publisher_sm     no_json_blanks document.send(GEOMG.FIELDS.PUBLISHER)
json.schema_provider_s    no_json_blanks document.send(GEOMG.FIELDS.PROVENANCE)
json.gbl_resourceClass_sm no_json_blanks document.send(GEOMG.FIELDS.B1G_GENRE)
json.gbl_resourceType_sm  no_json_blanks document.send(GEOMG.FIELDS.LAYER_GEOM_TYPE)
json.dct_subject_sm       no_json_blanks document.send(GEOMG.FIELDS.SUBJECT)
json.dcat_theme_sm        no_json_blanks document.send(GEOMG.FIELDS.THEME)
json.dcat_keyword_sm      no_json_blanks document.send(GEOMG.FIELDS.B1G_KEYWORD)
json.dct_temporal_sm      no_json_blanks document.send(GEOMG.FIELDS.TEMPORAL)
json.dct_issued_s         no_json_blanks document.send(GEOMG.FIELDS.ISSUED)
json.gbl_indexYear_im     no_json_blanks document.send(GEOMG.FIELDS.YEAR)
json.gbl_dateRange_drsim  no_json_blanks document.date_range_json
json.dct_spatial_sm       no_json_blanks document.send(GEOMG.FIELDS.SPATIAL)
json.locn_geometry        no_json_blanks document.derive_locn_geometry
json.dcat_bbox            no_json_blanks document.derive_dcat_bbox
json.dcat_centroid        no_json_blanks document.derive_dcat_centroid
json.dct_relation_sm      no_json_blanks document.send(GEOMG.FIELDS.RELATION)
json.pcdm_memberOf_sm     no_json_blanks document.send(GEOMG.FIELDS.MEMBER_OF)
json.dct_isPartOf_sm      no_json_blanks document.send(GEOMG.FIELDS.IS_PART_OF)
json.dct_source_sm        no_json_blanks document.send(GEOMG.FIELDS.SOURCE)
json.dct_isVersionOf_sm   no_json_blanks document.send(GEOMG.FIELDS.IS_VERSION_OF)
json.dct_replaces_sm      no_json_blanks document.send(GEOMG.FIELDS.REPLACES)
json.dct_isReplacedBy_sm  no_json_blanks document.send(GEOMG.FIELDS.IS_REPLACED_BY)
json.dct_rights_sm        no_json_blanks document.send(GEOMG.FIELDS.RIGHTS)
json.dct_rightsHolder_sm  no_json_blanks document.send(GEOMG.FIELDS.RIGHTS_HOLDER)
json.dct_license_sm       no_json_blanks document.send(GEOMG.FIELDS.LICENSE)
json.dct_accessRights_s   no_json_blanks document.send(GEOMG.FIELDS.ACCESS_RIGHTS)
json.dct_format_s         no_json_blanks document.send(GEOMG.FIELDS.FORMAT)
json.gbl_fileSize_s       no_json_blanks document.send(GEOMG.FIELDS.FILE_SIZE)
json.gbl_wxsIdentifier_s  no_json_blanks document.send(GEOMG.FIELDS.LAYER_ID)
json.dct_references_s     no_json_blanks document.references_json
json.id                   no_json_blanks document.send(GEOMG.FIELDS.LAYER_SLUG)
json.dct_identifier_sm    no_json_blanks document.send(GEOMG.FIELDS.IDENTIFIER)
json.gbl_mdModified_dt    no_json_blanks document.send(GEOMG.FIELDS.LAYER_MODIFIED)
json.gbl_mdVersion_s      no_json_blanks 'Aardvark'
json.gbl_suppressed_b     no_json_blanks document.send(GEOMG.FIELDS.SUPPRESSED)
json.gbl_georeferenced_b  no_json_blanks document.send(GEOMG.FIELDS.GEOREFERENCED)
