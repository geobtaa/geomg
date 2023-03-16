# frozen_string_literal: true

# @TODO
# - GeoNames
module Geomg
  module_function

  def field_mappings_btaa_aardvark
    {
      dct_title_s: {
        destination: GEOMG_SOLR_FIELDS[:title],
        delimited: false,
        transformation_method: nil
      },
      dct_alternative_sm: {
        destination: GEOMG_SOLR_FIELDS[:alternative_title],
        delimited: true,
        transformation_method: nil
      },
      dct_description_sm: {
        destination: GEOMG_SOLR_FIELDS[:description],
        delimited: true,
        transformation_method: nil
      },
      dct_language_sm: {
        destination: GEOMG_SOLR_FIELDS[:language],
        delimited: true,
        transformation_method: nil
      },
      dct_creator_sm: {
        destination: GEOMG_SOLR_FIELDS[:creator],
        delimited: true,
        transformation_method: nil
      },
      dct_publisher_sm: {
        destination: GEOMG_SOLR_FIELDS[:publisher],
        delimited: true,
        transformation_method: nil
      },
      schema_provider_s: {
        destination: GEOMG_SOLR_FIELDS[:provider],
        delimited: false,
        transformation_method: nil
      },
      gbl_resourceClass_sm: {
        destination: GEOMG_SOLR_FIELDS[:resource_class],
        delimited: true,
        transformation_method: nil
      },
      gbl_resourceType_sm: {
        destination: GEOMG_SOLR_FIELDS[:resource_type],
        delimited: true,
        transformation_method: nil
      },
      dct_subject_sm: {
        destination: GEOMG_SOLR_FIELDS[:subject],
        delimited: true,
        transformation_method: nil
      },
      dcat_theme_sm: {
        destination: GEOMG_SOLR_FIELDS[:theme],
        delimited: true,
        transformation_method: nil
      },
      dcat_keyword_sm: {
        destination: GEOMG_SOLR_FIELDS[:keyword],
        delimited: true,
        transformation_method: nil
      },
      dct_temporal_sm: {
        destination: GEOMG_SOLR_FIELDS[:temporal_coverage],
        delimited: true,
        transformation_method: nil
      },
      dct_issued_s: {
        destination: GEOMG_SOLR_FIELDS[:date_issued],
        delimited: false,
        transformation_method: nil
      },
      gbl_dateRange_drsim: {
        destination: GEOMG_SOLR_FIELDS[:date_range],
        delimited: true,
        transformation_method: nil
      },
      dct_spatial_sm: {
        destination: GEOMG_SOLR_FIELDS[:spatial_coverage],
        delimited: true,
        transformation_method: nil
      },
      locn_geometry: {
        destination: GEOMG_SOLR_FIELDS[:geometry],
        delimited: false,
        transformation_method: nil
      },
      dcat_bbox: {
        destination: GEOMG_SOLR_FIELDS[:bounding_box],
        delimited: false,
        transformation_method: nil
      },
      b1g_geonames_sm: {
        destination: GEOMG_SOLR_FIELDS[:geonames],
        delimited: true,
        transformation_method: nil
      },
      dct_relation_sm: {
        destination: GEOMG_SOLR_FIELDS[:relation],
        delimited: true,
        transformation_method: nil
      },
      pcdm_memberOf_sm: {
        destination: GEOMG_SOLR_FIELDS[:member_of],
        delimited: true,
        transformation_method: nil
      },
      dct_isPartOf_sm: {
        destination: GEOMG_SOLR_FIELDS[:is_part_of],
        delimited: true,
        transformation_method: nil
      },
      dct_source_sm: {
        destination: GEOMG_SOLR_FIELDS[:source],
        delimited: true,
        transformation_method: nil
      },
      dct_isVersionOf_sm: {
        destination: GEOMG_SOLR_FIELDS[:is_version_of],
        delimited: true,
        transformation_method: nil
      },
      dct_replaces_sm: {
        destination: GEOMG_SOLR_FIELDS[:replaces],
        delimited: true,
        transformation_method: nil
      },
      dct_isReplacedBy_sm: {
        destination: GEOMG_SOLR_FIELDS[:is_replaced_by],
        delimited: true,
        transformation_method: nil
      },
      dct_format_s: {
        destination: GEOMG_SOLR_FIELDS[:format],
        delimited: false,
        transformation_method: nil
      },
      gbl_fileSize_s: {
        destination: GEOMG_SOLR_FIELDS[:file_size],
        delimited: false,
        transformation_method: nil
      },
      gbl_wxsIdentifier_s: {
        destination: GEOMG_SOLR_FIELDS[:wxs_identifier],
        delimited: false,
        transformation_method: nil
      },
      gbl_georeferenced_b: {
        destination: GEOMG_SOLR_FIELDS[:georeferenced],
        delimited: false,
        transformation_method: nil
      },
      dct_references_s: {
        destination: GEOMG_SOLR_FIELDS[:reference],
        delimited: false,
        transformation_method: "build_dct_references"
      },
      b1g_image_ss: {
        destination: GEOMG_SOLR_FIELDS[:b1g_image_url],
        delimited: false,
        transformation_method: nil
      },
      geomg_id_s: {
        destination: GEOMG_SOLR_FIELDS[:id],
        delimited: false,
        transformation_method: nil
      },
      dct_identifier_sm: {
        destination: GEOMG_SOLR_FIELDS[:identifier],
        delimited: true,
        transformation_method: nil
      },
      b1g_code_s: {
        destination: GEOMG_SOLR_FIELDS[:code],
        delimited: false,
        transformation_method: nil
      },

      layer_geom_type_s: {
        destination: GEOMG_SOLR_FIELDS[:resource_type],
        delimited: false,
        transformation_method: nil
      },
      dc_rights_sm: {
        destination: GEOMG_SOLR_FIELDS[:rights],
        delimited: true,
        transformation_method: nil
      },
      dct_rightsHolder_sm: {
        destination: GEOMG_SOLR_FIELDS[:right_holder],
        delimited: true,
        transformation_method: nil
      },
      dct_license_sm: {
        destination: GEOMG_SOLR_FIELDS[:license],
        delimited: true,
        transformation_method: nil
      },
      dct_accessRights_s: {
        destination: GEOMG_SOLR_FIELDS[:access_right],
        delimited: false,
        transformation_method: nil
      },
      b1g_dct_accrualMethod_s: {
        destination: GEOMG_SOLR_FIELDS[:accrual_method],
        delimited: false,
        transformation_method: nil
      },
      b1g_dct_accrualPeriodicity_s: {
        destination: GEOMG_SOLR_FIELDS[:accrual_periodicity],
        delimited: false,
        transformation_method: nil
      },
      b1g_dateAccessioned_sm: {
        destination: GEOMG_SOLR_FIELDS[:date_accessioned],
        delimited: true,
        transformation_method: nil
      },
      b1g_dateRetired_s: {
        destination: GEOMG_SOLR_FIELDS[:date_retired],
        delimited: false,
        transformation_method: nil
      },
      b1g_status_s: {
        destination: GEOMG_SOLR_FIELDS[:status],
        delimited: false,
        transformation_method: nil
      },
      gbl_suppressed_b: {
        destination: GEOMG_SOLR_FIELDS[:suppressed_record],
        delimited: false,
        transformation_method: nil
      },
      b1g_child_record_b: {
        destination: GEOMG_SOLR_FIELDS[:child_record],
        delimited: false,
        transformation_method: nil
      },
      b1g_dct_mediator_sm: {
        destination: GEOMG_SOLR_FIELDS[:mediator],
        delimited: false,
        transformation_method: nil
      },
      b1g_access_s: {
        destination: GEOMG_SOLR_FIELDS[:access],
        delimited: false,
        transformation_method: nil
      },
      gbl_mdVersion_s: {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      gbl_indexYear_im: {
        destination: GEOMG_SOLR_FIELDS[:index_year],
        delimited: false,
        transformation_method: nil
      },
      gbl_mdModified_dt: {
        destination: GEOMG_SOLR_FIELDS[:updated_at],
        delimited: false,
        transformation_method: nil
      },
      score: {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      solr_bboxtype: {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      solr_bboxtype__maxX: {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      solr_bboxtype__minX: {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      solr_bboxtype__maxY: {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      solr_bboxtype__minY: {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      timestamp: {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      _version_: {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      cugir_category_sm: {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      b1g_centroid_ss: {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      dcat_centroid: {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      nyu_addl_dspace_s: {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      georss_polygon_s: {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      cugir_addl_downloads_s: {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      cugir_filesize_s: {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      stanford_rights_metadata_s: {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      }
    }
  end

  def uri_2_category_references_mappings
    ActiveSupport::HashWithIndifferentAccess.new({
      "http://www.opengis.net/def/serviceType/ogc/wcs": "wcs",
      "http://www.opengis.net/def/serviceType/ogc/wms": "wms",
      "http://www.opengis.net/def/serviceType/ogc/wfs": "wfs",
      "http://iiif.io/api/image": "iiif_image",
      "http://iiif.io/api/presentation#manifest": "iiif_manifest",
      "http://schema.org/image": "image",
      "http://schema.org/downloadUrl": "download",
      "http://schema.org/thumbnailUrl": "thumbnail",
      "http://lccn.loc.gov/sh85035852": "documentation_download",
      "http://schema.org/url": "documentation_external",
      "http://www.isotc211.org/schemas/2005/gmd/": "metadata_iso",
      "http://www.opengis.net/cat/csw/csdgm": "metadata_fgdc",
      "http://www.loc.gov/mods/v3": "metadata_mods",
      "http://www.w3.org/1999/xhtml": "metadata_html",
      "urn:x-esri:serviceType:ArcGIS#FeatureLayer": "arcgis_feature_layer",
      "urn:x-esri:serviceType:ArcGIS#TiledMapLayer": "arcgis_tiled_map_layer",
      "urn:x-esri:serviceType:ArcGIS#DynamicMapLayer": "arcgis_dynamic_map_layer",
      "urn:x-esri:serviceType:ArcGIS#ImageMapLayer": "arcgis_image_map_layer",
      "http://schema.org/DownloadAction": "harvard",
      "https://openindexmaps.org": "open_index_map",
      "https://oembed.com": "oembed"
    })
  end
end
