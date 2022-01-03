# frozen_string_literal: true

# @TODO
# - GeoNames
module Geomg
  module_function

  def field_mappings_btaa_aardvark
    {
      'dct_title_s': {
        destination: GEOMG.FIELDS.TITLE,
        delimited: false,
        transformation_method: nil
      },
      'dct_alternative_sm': {
        destination: GEOMG.FIELDS.ALT_TITLE,
        delimited: true,
        transformation_method: nil
      },
      'dct_description_sm': {
        destination: GEOMG.FIELDS.DESCRIPTION,
        delimited: true,
        transformation_method: nil
      },
      'dct_language_sm': {
        destination: GEOMG.FIELDS.LANGUAGE,
        delimited: true,
        transformation_method: nil
      },
      'dct_creator_sm': {
        destination: GEOMG.FIELDS.CREATOR,
        delimited: true,
        transformation_method: nil
      },
      'dct_publisher_sm': {
        destination: GEOMG.FIELDS.PUBLISHER,
        delimited: true,
        transformation_method: nil
      },
      'schema_provider_s': {
        destination: GEOMG.FIELDS.PROVENANCE,
        delimited: false,
        transformation_method: nil
      },
      'gbl_resourceClass_sm': {
        destination: GEOMG.FIELDS.B1G_GENRE,
        delimited: true,
        transformation_method: nil
      },
      'gbl_resourceType_sm': {
        destination: GEOMG.FIELDS.LAYER_GEOM_TYPE,
        delimited: true,
        transformation_method: nil
      },
      'dct_subject_sm': {
        destination: GEOMG.FIELDS.SUBJECT,
        delimited: true,
        transformation_method: nil
      },
      'dcat_theme_sm': {
        destination: GEOMG.FIELDS.THEME,
        delimited: true,
        transformation_method: nil
      },
      'dcat_keyword_sm': {
        destination: GEOMG.FIELDS.B1G_KEYWORD,
        delimited: true,
        transformation_method: nil
      },
      'dct_temporal_sm': {
        destination: GEOMG.FIELDS.TEMPORAL,
        delimited: true,
        transformation_method: nil
      },
      'dct_issued_s': {
        destination: GEOMG.FIELDS.ISSUED,
        delimited: false,
        transformation_method: nil
      },
      'gbl_dateRange_drsim': {
        destination: GEOMG.FIELDS.B1G_DATE_RANGE,
        delimited: true,
        transformation_method: nil
      },
      'dct_spatial_sm': {
        destination: GEOMG.FIELDS.SPATIAL,
        delimited: true,
        transformation_method: nil
      },
      'locn_geometry': {
        destination: GEOMG.FIELDS.GEOM,
        delimited: false,
        transformation_method: nil
      },
      'b1g_geonames_sm': {
        destination: GEOMG.FIELDS.B1G_GEONAMES,
        delimited: true,
        transformation_method: nil
      },
      'dct_relation_sm': {
        destination: GEOMG.FIELDS.RELATION,
        delimited: true,
        transformation_method: nil
      },
      'pcdm_memberOf_sm': {
        destination: GEOMG.FIELDS.MEMBER_OF,
        delimited: true,
        transformation_method: nil
      },
      'dct_isPartOf_sm': {
        destination: GEOMG.FIELDS.IS_PART_OF,
        delimited: true,
        transformation_method: nil
      },
      'dct_source_sm': {
        destination: GEOMG.FIELDS.SOURCE,
        delimited: true,
        transformation_method: nil
      },
      'dct_isVersionOf_sm': {
        destination: GEOMG.FIELDS.IS_VERSION_OF,
        delimited: true,
        transformation_method: nil
      },
      'dct_replaces_sm': {
        destination: GEOMG.FIELDS.REPLACES,
        delimited: true,
        transformation_method: nil
      },
      'dct_isReplacedBy_sm': {
        destination: GEOMG.FIELDS.IS_REPLACED_BY,
        delimited: true,
        transformation_method: nil
      },
      'dct_format_s': {
        destination: GEOMG.FIELDS.FORMAT,
        delimited: false,
        transformation_method: nil
      },
      'gbl_fileSize_s': {
        destination: GEOMG.FIELDS.FILE_SIZE,
        delimited: false,
        transformation_method: nil
      },
      'gbl_wxsIdentifier_s': {
        destination: GEOMG.FIELDS.LAYER_ID,
        delimited: false,
        transformation_method: nil
      },
      'gbl_georeferenced_b': {
        destination: GEOMG.FIELDS.GEOREFERENCED,
        delimited: false,
        transformation_method: nil
      },
      'dct_references_s': {
        'destination': GEOMG.FIELDS.REFERENCES,
        'delimited': false,
        'transformation_method': 'build_dct_references'
      },
      'b1g_image_ss': {
        destination: GEOMG.FIELDS.B1G_IMAGE,
        delimited: false,
        transformation_method: nil
      },
      'geomg_id_s': {
        destination: GEOMG.FIELDS.LAYER_SLUG,
        delimited: false,
        transformation_method: nil
      },
      'dct_identifier_sm': {
        destination: GEOMG.FIELDS.IDENTIFIER,
        delimited: true,
        transformation_method: nil
      },
      'b1g_code_s': {
        destination: GEOMG.FIELDS.B1G_CODE,
        delimited: false,
        transformation_method: nil
      },

      'layer_geom_type_s': {
        destination: GEOMG.FIELDS.LAYER_GEOM_TYPE,
        delimited: false,
        transformation_method: nil
      },
      'dc_rights_sm': {
        destination: GEOMG.FIELDS.RIGHTS,
        delimited: true,
        transformation_method: nil
      },
      'dct_rightsHolder_sm': {
        destination: GEOMG.FIELDS.RIGHTS_HOLDER,
        delimited: true,
        transformation_method: nil
      },
      'dct_license_sm': {
        destination: GEOMG.FIELDS.LICENSE,
        delimited: true,
        transformation_method: nil
      },
      'dct_accessRights_s': {
        destination: GEOMG.FIELDS.ACCESS_RIGHTS,
        delimited: false,
        transformation_method: nil
      },
      'b1g_dct_accrualMethod_s': {
        destination: GEOMG.FIELDS.B1G_ACCRUAL_METHOD,
        delimited: false,
        transformation_method: nil
      },
      'b1g_dct_accrualPeriodicity_s': {
        destination: GEOMG.FIELDS.B1G_ACCRUAL_PERIODICITY,
        delimited: false,
        transformation_method: nil
      },
      'b1g_dateAccessioned_sm': {
        destination: GEOMG.FIELDS.B1G_DATE_ACCESSIONED,
        delimited: true,
        transformation_method: nil
      },
      'b1g_dateRetired_s': {
        destination: GEOMG.FIELDS.B1G_DATE_RETIRED,
        delimited: false,
        transformation_method: nil
      },
      'b1g_status_s': {
        destination: GEOMG.FIELDS.B1G_STATUS,
        delimited: false,
        transformation_method: nil
      },
      'gbl_suppressed_b': {
        destination: GEOMG.FIELDS.SUPPRESSED,
        delimited: false,
        transformation_method: nil
      },
      'b1g_child_record_b': {
        destination: GEOMG.FIELDS.B1G_CHILD_RECORD,
        delimited: false,
        transformation_method: nil
      },
      'b1g_dct_mediator_sm': {
        destination: GEOMG.FIELDS.B1G_MEDIATOR,
        delimited: false,
        transformation_method: nil
      },
      'b1g_access_s': {
        destination: GEOMG.FIELDS.B1G_ACCESS,
        delimited: false,
        transformation_method: nil
      },
      'gbl_mdVersion_s': {
        destination: 'Discard',
        delimited: false,
        transformation_method: nil
      },
      'gbl_indexYear_im': {
        destination: GEOMG.FIELDS.YEAR,
        delimited: false,
        transformation_method: nil
      },
      'gbl_mdModified_dt': {
        destination: GEOMG.FIELDS.LAYER_MODIFIED,
        delimited: false,
        transformation_method: nil
      },
      'score': {
        destination: 'Discard',
        delimited: false,
        transformation_method: nil
      },
      'solr_bboxtype': {
        destination: 'Discard',
        delimited: false,
        transformation_method: nil
      },
      'solr_bboxtype__maxX': {
        destination: 'Discard',
        delimited: false,
        transformation_method: nil
      },
      'solr_bboxtype__minX': {
        destination: 'Discard',
        delimited: false,
        transformation_method: nil
      },
      'solr_bboxtype__maxY': {
        destination: 'Discard',
        delimited: false,
        transformation_method: nil
      },
      'solr_bboxtype__minY': {
        destination: 'Discard',
        delimited: false,
        transformation_method: nil
      },
      'timestamp': {
        destination: 'Discard',
        delimited: false,
        transformation_method: nil
      },
      '_version_': {
        destination: 'Discard',
        delimited: false,
        transformation_method: nil
      },
      'cugir_category_sm': {
        destination: 'Discard',
        delimited: false,
        transformation_method: nil
      },
      'b1g_centroid_ss': {
        destination: 'Discard',
        delimited: false,
        transformation_method: nil
      },
      'nyu_addl_dspace_s': {
        destination: 'Discard',
        delimited: false,
        transformation_method: nil
      },
      'georss_polygon_s': {
        destination: 'Discard',
        delimited: false,
        transformation_method: nil
      },
      'cugir_addl_downloads_s': {
        destination: 'Discard',
        delimited: false,
        transformation_method: nil
      },
      'cugir_filesize_s': {
        destination: 'Discard',
        delimited: false,
        transformation_method: nil
      },
      'stanford_rights_metadata_s': {
        destination: 'Discard',
        delimited: false,
        transformation_method: nil
      }
    }
  end

  def uri_2_category_references_mappings
    ActiveSupport::HashWithIndifferentAccess.new({
      'http://www.opengis.net/def/serviceType/ogc/wcs': 'wcs',
      'http://www.opengis.net/def/serviceType/ogc/wms': 'wms',
      'http://www.opengis.net/def/serviceType/ogc/wfs': 'wfs',
      'http://iiif.io/api/image': 'iiif_image',
      'http://iiif.io/api/presentation#manifest': 'iiif_manifest',
      'http://schema.org/image': 'image',
      'http://schema.org/downloadUrl': 'download',
      'http://schema.org/thumbnailUrl': 'thumbnail',
      'http://lccn.loc.gov/sh85035852': 'documentation_download',
      'http://schema.org/url': 'documentation_external',
      'http://www.isotc211.org/schemas/2005/gmd/': 'metadata_iso',
      'http://www.opengis.net/cat/csw/csdgm': 'metadata_fgdc',
      'http://www.loc.gov/mods/v3': 'metadata_mods',
      'http://www.w3.org/1999/xhtml': 'metadata_html',
      'urn:x-esri:serviceType:ArcGIS#FeatureLayer': 'arcgis_feature_layer',
      'urn:x-esri:serviceType:ArcGIS#TiledMapLayer': 'arcgis_tiled_map_layer',
      'urn:x-esri:serviceType:ArcGIS#DynamicMapLayer': 'arcgis_dynamic_map_layer',
      'urn:x-esri:serviceType:ArcGIS#ImageMapLayer': 'arcgis_image_map_layer',
      'http://schema.org/DownloadAction': 'harvard',
      'https://openindexmaps.org': 'open_index_map',
      'https://oembed.com': 'oembed'
    })
  end
end
