# frozen_string_literal: true

# @TODO
# - Centroids
# - GeoNames
module Geomg
  module_function

  def field_mappings_gblv1
    {
      'dc_title_s': {
        destination: GEOMG_SOLR_FIELDS[:title],
        delimited: false,
        transformation_method: nil
      },
      'alternativeTitle_sm': {
        destination: GEOMG_SOLR_FIELDS[:alternative_title],
        delimited: true,
        transformation_method: nil
      },
      'dct_alternativeTitle_sm': {
        destination: GEOMG_SOLR_FIELDS[:alternative_title],
        delimited: true,
        transformation_method: nil
      },
      'dc_description_s': {
        destination: GEOMG_SOLR_FIELDS[:description],
        delimited: false,
        transformation_method: nil
      },
      'dc_language_s': {
        destination: GEOMG_SOLR_FIELDS[:language],
        delimited: true,
        transformation_method: nil
      },
      'dc_language_sm': {
        destination: GEOMG_SOLR_FIELDS[:language],
        delimited: true,
        transformation_method: nil
      },
      'dc_publisher_s': {
        destination: GEOMG_SOLR_FIELDS[:publisher],
        delimited: true,
        transformation_method: nil
      },
      'dc_publisher_sm': {
        destination: GEOMG_SOLR_FIELDS[:publisher],
        delimited: true,
        transformation_method: nil
      },
      'dc_creator_sm': {
        destination: GEOMG_SOLR_FIELDS[:creator],
        delimited: true,
        transformation_method: nil
      },
      'b1g_genre_sm': {
        destination: GEOMG_SOLR_FIELDS[:resource_class],
        delimited: true,
        transformation_method: nil
      },
      'dc_subject_sm': {
        destination: GEOMG_SOLR_FIELDS[:subject],
        delimited: true,
        transformation_method: nil
      },
      'b1g_keyword_sm': {
        destination: GEOMG_SOLR_FIELDS[:keyword],
        delimited: true,
        transformation_method: nil
      },
      'dct_issued_s': {
        destination: GEOMG_SOLR_FIELDS[:date_issued],
        delimited: false,
        transformation_method: nil
      },
      'dct_temporal_sm': {
        destination: GEOMG_SOLR_FIELDS[:temporal_coverage],
        delimited: true,
        transformation_method: nil
      },
      'b1g_date_range_drsim': {
        destination: GEOMG_SOLR_FIELDS[:date_range],
        delimited: true,
        transformation_method: nil
      },
      'dct_spatial_sm': {
        destination: GEOMG_SOLR_FIELDS[:spatial_coverage],
        delimited: true,
        transformation_method: nil
      },
      'b1g_geonames_sm': {
        destination: GEOMG_SOLR_FIELDS[:geonames],
        delimited: true,
        transformation_method: nil
      },
      'solr_geom': {
        destination: GEOMG_SOLR_FIELDS[:geometry],
        delimited: false,
        transformation_method: nil
      },
      'dc_format_s': {
        destination: GEOMG_SOLR_FIELDS[:format],
        delimited: false,
        transformation_method: nil
      },
      'layer_geom_type_s': {
        destination: GEOMG_SOLR_FIELDS[:resource_type],
        delimited: false,
        transformation_method: nil
      },
      'layer_id_s': {
        destination: GEOMG_SOLR_FIELDS[:wxs_identifier],
        delimited: false,
        transformation_method: nil
      },
      'dct_references_s': {
        'destination': GEOMG_SOLR_FIELDS[:reference],
        'delimited': false,
        'transformation_method': "build_dct_references"
      },
      'b1g_image_ss': {
        destination: GEOMG_SOLR_FIELDS[:b1g_image_url],
        delimited: false,
        transformation_method: nil
      },
      'dc_identifier_s': {
        destination: GEOMG_SOLR_FIELDS[:identifier],
        delimited: false,
        transformation_method: nil
      },
      'layer_slug_s': {
        destination: GEOMG_SOLR_FIELDS[:id],
        delimited: false,
        transformation_method: nil
      },
      'dct_provenance_s': {
        destination: GEOMG_SOLR_FIELDS[:provider],
        delimited: false,
        transformation_method: nil
      },
      'b1g_code_s': {
        destination: GEOMG_SOLR_FIELDS[:code],
        delimited: false,
        transformation_method: nil
      },
      'dct_isPartOf_sm': {
        destination: GEOMG_SOLR_FIELDS[:is_part_of],
        delimited: true,
        transformation_method: nil
      },
      'dc_source_sm': {
        destination: GEOMG_SOLR_FIELDS[:source],
        delimited: true,
        transformation_method: nil
      },
      'b1g_status_s': {
        destination: GEOMG_SOLR_FIELDS[:status],
        delimited: false,
        transformation_method: nil
      },
      'dct_accrualMethod_s': {
        destination: GEOMG_SOLR_FIELDS[:accrual_method],
        delimited: false,
        transformation_method: nil
      },
      'Accrual Periodicity': {
        destination: GEOMG_SOLR_FIELDS[:accrual_periodicity],
        delimited: false,
        transformation_method: nil
      },
      'b1g_dateAccessioned_s': {
        destination: GEOMG_SOLR_FIELDS[:date_accessioned],
        delimited: false,
        transformation_method: nil
      },
      'b1g_dateRetired_s': {
        destination: GEOMG_SOLR_FIELDS[:date_retired],
        delimited: false,
        transformation_method: nil
      },
      'dc_rights_s': {
        destination: GEOMG_SOLR_FIELDS[:rights],
        delimited: false,
        transformation_method: nil
      },
      'dct_accessRights_sm': {
        destination: GEOMG_SOLR_FIELDS[:access_rights],
        delimited: true,
        transformation_method: nil
      },
      'suppressed_b': {
        destination: GEOMG_SOLR_FIELDS[:suppressed_record],
        delimited: false,
        transformation_method: nil
      },
      'b1g_child_record_b': {
        destination: GEOMG_SOLR_FIELDS[:child_record],
        delimited: false,
        transformation_method: nil
      },
      'solr_year_i': {
        destination: GEOMG_SOLR_FIELDS[:index_year],
        delimited: false,
        transformation_method: nil
      },
      'layer_modified_dt': {
        destination: "layer_modified_dt",
        delimited: false,
        transformation_method: nil
      },
      'dct_mediator_sm': {
        destination: GEOMG_SOLR_FIELDS[:mediator],
        delimited: false,
        transformation_method: nil
      },
      'score': {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      'cugir_category_sm': {
        destination: "cugir_category_sm",
        delimited: false,
        transformation_method: nil
      },
      'solr_bboxtype': {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      'b1g_access_s': {
        destination: GEOMG_SOLR_FIELDS[:access],
        delimited: false,
        transformation_method: nil
      },
      'geoblacklight_version': {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      'nyu_addl_dspace_s': {
        destination: "nyu_addl_dspace_s",
        delimited: false,
        transformation_method: nil
      },
      'b1g_collection_sm': {
        destination: "b1g_collection_sm",
        delimited: false,
        transformation_method: nil
      },
      'georss_polygon_s': {
        destination: "georss_polygon_s",
        delimited: false,
        transformation_method: nil
      },
      'dct_accrual_sm': {
        destination: "dct_accrual_sm",
        delimited: false,
        transformation_method: nil
      },
      'solr_bboxtype__maxX': {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      'solr_bboxtype__minX': {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      'solr_bboxtype__maxY': {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      'solr_bboxtype__minY': {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      'call_number_s': {
        destination: "call_number_s",
        delimited: false,
        transformation_method: nil
      },
      'timestamp': {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      'b1g_centroid_ss': {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      'cugir_addl_downloads_s': {
        destination: "cugir_addl_downloads_s",
        delimited: false,
        transformation_method: nil
      },
      'cugir_filesize_s': {
        destination: "cugir_filesize_s",
        delimited: false,
        transformation_method: nil
      },
      '_version_': {
        destination: "Discard",
        delimited: false,
        transformation_method: nil
      },
      'stanford_rights_metadata_s': {
        destination: "stanford_rights_metadata_s",
        delimited: false,
        transformation_method: nil
      }
    }
  end

  def uri_2_category_references_mappings
    ActiveSupport::HashWithIndifferentAccess.new({
      'http://www.opengis.net/def/serviceType/ogc/wcs': "wcs",
      'http://www.opengis.net/def/serviceType/ogc/wms': "wms",
      'http://www.opengis.net/def/serviceType/ogc/wfs': "wfs",
      'http://iiif.io/api/image': "iiif_image",
      'http://iiif.io/api/presentation#manifest': "iiif_manifest",
      'http://schema.org/image': "image",
      'http://schema.org/downloadUrl': "download",
      'http://schema.org/thumbnailUrl': "thumbnail",
      'http://lccn.loc.gov/sh85035852': "documentation_download",
      'http://schema.org/url': "documentation_external",
      'http://www.isotc211.org/schemas/2005/gmd/': "metadata_iso",
      'http://www.opengis.net/cat/csw/csdgm': "metadata_fgdc",
      'http://www.loc.gov/mods/v3': "metadata_mods",
      'http://www.w3.org/1999/xhtml': "metadata_html",
      'urn:x-esri:serviceType:ArcGIS#FeatureLayer': "arcgis_feature_layer",
      'urn:x-esri:serviceType:ArcGIS#TiledMapLayer': "arcgis_tiled_map_layer",
      'urn:x-esri:serviceType:ArcGIS#DynamicMapLayer': "arcgis_dynamic_map_layer",
      'urn:x-esri:serviceType:ArcGIS#ImageMapLayer': "arcgis_image_map_layer",
      'http://schema.org/DownloadAction': "harvard",
      'https://openindexmaps.org': "open_index_map",
      'https://oembed.com': "oembed"
    })
  end
end
