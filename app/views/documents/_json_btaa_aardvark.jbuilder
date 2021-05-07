# frozen_string_literal: true

# @TODO Add BTAA/Aardvark Schema Documentation

# Required
json.gbl_mdVersion_s 'Aardvark'
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
json.gbl_dateRange_drsim  document.date_range_json
json.dct_spatial_sm       document.send(GEOMG.FIELDS.SPATIAL)
json.locn_geometry        document.solr_geom_mapping
json.dcat_centroid_ss     document.send(GEOMG.FIELDS.B1G_CENTROID)
json.b1g_geonames_sm      document.send(GEOMG.FIELDS.B1G_GEONAMES)
json.dct_relation_sm      document.send(GEOMG.FIELDS.RELATION)
json.pcdm_memberOf_sm     document.send(GEOMG.FIELDS.MEMBER_OF)
json.dct_isPartOf_sm      document.send(GEOMG.FIELDS.IS_PART_OF)
json.dct_source_sm        document.send(GEOMG.FIELDS.SOURCE)
json.dct_isVersionOf_sm   document.send(GEOMG.FIELDS.IS_VERSION_OF)
json.dct_replaces_sm      document.send(GEOMG.FIELDS.REPLACES)
json.dct_isReplacedBy_sm  document.send(GEOMG.FIELDS.IS_REPLACED_BY)
json.dct_format_s         document.send(GEOMG.FIELDS.FORMAT)
json.gbl_fileSize_s       document.send(GEOMG.FIELDS.FILE_SIZE)
json.gbl_wxsIdentifier_s  document.send(GEOMG.FIELDS.LAYER_ID)
json.gbl_georeferenced_b  document.send(GEOMG.FIELDS.GEOREFERENCED)
json.dct_references_s     document.references_json
json.b1g_image_ss         document.send(GEOMG.FIELDS.B1G_IMAGE)
json.geomg_id_s           document.send(GEOMG.FIELDS.LAYER_SLUG)
json.dct_identifier_sm    document.send(GEOMG.FIELDS.IDENTIFIER)
json.b1g_code_s           document.send(GEOMG.FIELDS.B1G_CODE)
json.dct_accessRights_s   document.send(GEOMG.FIELDS.ACCESS_RIGHTS)
json.dct_rightsHolder_sm  document.send(GEOMG.FIELDS.RIGHTS_HOLDER)
json.dct_license_sm       document.send(GEOMG.FIELDS.LICENSE)
json.dct_rights_sm        document.send(GEOMG.FIELDS.RIGHTS)
json.b1g_dct_accrualMethod_s document.send(GEOMG.FIELDS.B1G_ACCRUAL_METHOD)
json.b1g_dct_accrualPeriodicity_s document.send(GEOMG.FIELDS.B1G_ACCRUAL_PERIODICITY)
json.b1g_dateAccessioned_sm document.send(GEOMG.FIELDS.B1G_DATE_ACCESSIONED)
json.b1g_dateRetired_s      document.send(GEOMG.FIELDS.B1G_DATE_RETIRED)
json.b1g_status_s           document.send(GEOMG.FIELDS.B1G_STATUS)
json.gbl_suppressed_b       document.send(GEOMG.FIELDS.SUPPRESSED)
json.b1g_child_record_b     document.send(GEOMG.FIELDS.B1G_CHILD_RECORD)
json.b1g_dct_mediator_sm    document.send(GEOMG.FIELDS.B1G_MEDIATOR)
json.b1g_access_s           document.send(GEOMG.FIELDS.B1G_ACCESS)
json.gbl_indexYear_im       document.send(GEOMG.FIELDS.YEAR)
json.gbl_mdModified_dt      document.send(GEOMG.FIELDS.LAYER_MODIFIED)
