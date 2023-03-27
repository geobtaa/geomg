# frozen_string_literal: true

# @TODO
# - GeoNames
module Geomg
  class FieldMappingsBtaaAardvark
    def self.call
      {
        dct_title_s: {
          destination: Geomg::Schema.instance.solr_fields[:title],
          delimited: false,
          transformation_method: nil
        },
        dct_alternative_sm: {
          destination: Geomg::Schema.instance.solr_fields[:alternative_title],
          delimited: true,
          transformation_method: nil
        },
        dct_description_sm: {
          destination: Geomg::Schema.instance.solr_fields[:description],
          delimited: true,
          transformation_method: nil
        },
        dct_language_sm: {
          destination: Geomg::Schema.instance.solr_fields[:language],
          delimited: true,
          transformation_method: nil
        },
        dct_creator_sm: {
          destination: Geomg::Schema.instance.solr_fields[:creator],
          delimited: true,
          transformation_method: nil
        },
        dct_publisher_sm: {
          destination: Geomg::Schema.instance.solr_fields[:publisher],
          delimited: true,
          transformation_method: nil
        },
        schema_provider_s: {
          destination: Geomg::Schema.instance.solr_fields[:provider],
          delimited: false,
          transformation_method: nil
        },
        gbl_resourceClass_sm: {
          destination: Geomg::Schema.instance.solr_fields[:resource_class],
          delimited: true,
          transformation_method: nil
        },
        gbl_resourceType_sm: {
          destination: Geomg::Schema.instance.solr_fields[:resource_type],
          delimited: true,
          transformation_method: nil
        },
        dct_subject_sm: {
          destination: Geomg::Schema.instance.solr_fields[:subject],
          delimited: true,
          transformation_method: nil
        },
        dcat_theme_sm: {
          destination: Geomg::Schema.instance.solr_fields[:theme],
          delimited: true,
          transformation_method: nil
        },
        dcat_keyword_sm: {
          destination: Geomg::Schema.instance.solr_fields[:keyword],
          delimited: true,
          transformation_method: nil
        },
        dct_temporal_sm: {
          destination: Geomg::Schema.instance.solr_fields[:temporal_coverage],
          delimited: true,
          transformation_method: nil
        },
        dct_issued_s: {
          destination: Geomg::Schema.instance.solr_fields[:date_issued],
          delimited: false,
          transformation_method: nil
        },
        gbl_dateRange_drsim: {
          destination: Geomg::Schema.instance.solr_fields[:date_range],
          delimited: true,
          transformation_method: nil
        },
        dct_spatial_sm: {
          destination: Geomg::Schema.instance.solr_fields[:spatial_coverage],
          delimited: true,
          transformation_method: nil
        },
        locn_geometry: {
          destination: Geomg::Schema.instance.solr_fields[:geometry],
          delimited: false,
          transformation_method: nil
        },
        dcat_bbox: {
          destination: Geomg::Schema.instance.solr_fields[:bounding_box],
          delimited: false,
          transformation_method: nil
        },
        b1g_geonames_sm: {
          destination: Geomg::Schema.instance.solr_fields[:geonames],
          delimited: true,
          transformation_method: nil
        },
        dct_relation_sm: {
          destination: Geomg::Schema.instance.solr_fields[:relation],
          delimited: true,
          transformation_method: nil
        },
        pcdm_memberOf_sm: {
          destination: Geomg::Schema.instance.solr_fields[:member_of],
          delimited: true,
          transformation_method: nil
        },
        dct_isPartOf_sm: {
          destination: Geomg::Schema.instance.solr_fields[:is_part_of],
          delimited: true,
          transformation_method: nil
        },
        dct_source_sm: {
          destination: Geomg::Schema.instance.solr_fields[:source],
          delimited: true,
          transformation_method: nil
        },
        dct_isVersionOf_sm: {
          destination: Geomg::Schema.instance.solr_fields[:is_version_of],
          delimited: true,
          transformation_method: nil
        },
        dct_replaces_sm: {
          destination: Geomg::Schema.instance.solr_fields[:replaces],
          delimited: true,
          transformation_method: nil
        },
        dct_isReplacedBy_sm: {
          destination: Geomg::Schema.instance.solr_fields[:is_replaced_by],
          delimited: true,
          transformation_method: nil
        },
        dct_format_s: {
          destination: Geomg::Schema.instance.solr_fields[:format],
          delimited: false,
          transformation_method: nil
        },
        gbl_fileSize_s: {
          destination: Geomg::Schema.instance.solr_fields[:file_size],
          delimited: false,
          transformation_method: nil
        },
        gbl_wxsIdentifier_s: {
          destination: Geomg::Schema.instance.solr_fields[:wxs_identifier],
          delimited: false,
          transformation_method: nil
        },
        gbl_georeferenced_b: {
          destination: Geomg::Schema.instance.solr_fields[:georeferenced],
          delimited: false,
          transformation_method: nil
        },
        dct_references_s: {
          destination: Geomg::Schema.instance.solr_fields[:reference],
          delimited: false,
          transformation_method: "build_dct_references"
        },
        b1g_image_ss: {
          destination: Geomg::Schema.instance.solr_fields[:b1g_image_url],
          delimited: false,
          transformation_method: nil
        },
        geomg_id_s: {
          destination: Geomg::Schema.instance.solr_fields[:id],
          delimited: false,
          transformation_method: nil
        },
        dct_identifier_sm: {
          destination: Geomg::Schema.instance.solr_fields[:identifier],
          delimited: true,
          transformation_method: nil
        },
        b1g_code_s: {
          destination: Geomg::Schema.instance.solr_fields[:code],
          delimited: false,
          transformation_method: nil
        },

        layer_geom_type_s: {
          destination: Geomg::Schema.instance.solr_fields[:resource_type],
          delimited: false,
          transformation_method: nil
        },
        dc_rights_sm: {
          destination: Geomg::Schema.instance.solr_fields[:rights],
          delimited: true,
          transformation_method: nil
        },
        dct_rightsHolder_sm: {
          destination: Geomg::Schema.instance.solr_fields[:right_holder],
          delimited: true,
          transformation_method: nil
        },
        dct_license_sm: {
          destination: Geomg::Schema.instance.solr_fields[:license],
          delimited: true,
          transformation_method: nil
        },
        dct_accessRights_s: {
          destination: Geomg::Schema.instance.solr_fields[:access_right],
          delimited: false,
          transformation_method: nil
        },
        b1g_dct_accrualMethod_s: {
          destination: Geomg::Schema.instance.solr_fields[:accrual_method],
          delimited: false,
          transformation_method: nil
        },
        b1g_dct_accrualPeriodicity_s: {
          destination: Geomg::Schema.instance.solr_fields[:accrual_periodicity],
          delimited: false,
          transformation_method: nil
        },
        b1g_dateAccessioned_sm: {
          destination: Geomg::Schema.instance.solr_fields[:date_accessioned],
          delimited: true,
          transformation_method: nil
        },
        b1g_dateRetired_s: {
          destination: Geomg::Schema.instance.solr_fields[:date_retired],
          delimited: false,
          transformation_method: nil
        },
        b1g_status_s: {
          destination: Geomg::Schema.instance.solr_fields[:status],
          delimited: false,
          transformation_method: nil
        },
        gbl_suppressed_b: {
          destination: Geomg::Schema.instance.solr_fields[:suppressed_record],
          delimited: false,
          transformation_method: nil
        },
        b1g_child_record_b: {
          destination: Geomg::Schema.instance.solr_fields[:child_record],
          delimited: false,
          transformation_method: nil
        },
        b1g_dct_mediator_sm: {
          destination: Geomg::Schema.instance.solr_fields[:mediator],
          delimited: false,
          transformation_method: nil
        },
        b1g_access_s: {
          destination: Geomg::Schema.instance.solr_fields[:access],
          delimited: false,
          transformation_method: nil
        },
        gbl_mdVersion_s: {
          destination: "Discard",
          delimited: false,
          transformation_method: nil
        },
        gbl_indexYear_im: {
          destination: Geomg::Schema.instance.solr_fields[:index_year],
          delimited: false,
          transformation_method: nil
        },
        gbl_mdModified_dt: {
          destination: Geomg::Schema.instance.solr_fields[:updated_at],
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

    def self.uri_2_category_references_mappings
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
end
