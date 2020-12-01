# frozen_string_literal: true

# @TODO
# - Centroids
# - GeoNames
module Geomg
  module_function

  def field_mappings_btaa
    {
      'Title': {
        destination: 'dc_title_s',
        delimited: false,
        transformation_method: nil
      },
      'Alternative Title': {
        destination: 'dct_alternativeTitle_sm',
        delimited: true,
        transformation_method: nil
      },
      'Description': {
        destination: 'dc_description_s',
        delimited: false,
        transformation_method: nil
      },
      'Language': {
        destination: 'dc_language_sm',
        delimited: true,
        transformation_method: nil
      },
      'Publisher': {
        destination: 'dc_publisher_sm',
        delimited: true,
        transformation_method: nil
      },
      'Creator': {
        destination: 'dc_creator_sm',
        delimited: true,
        transformation_method: nil
      },
      'Genre': {
        destination: 'b1g_genre_sm',
        delimited: true,
        transformation_method: nil
      },
      'Subject': {
        destination: 'dc_subject_sm',
        delimited: true,
        transformation_method: nil
      },
      'Keyword': {
        destination: 'b1g_keyword_sm',
        delimited: true,
        transformation_method: nil
      },
      'Date Issued': {
        destination: 'dct_issued_s',
        delimited: false,
        transformation_method: nil
      },
      'Temporal Coverage': {
        destination: 'dct_temporal_sm',
        delimited: true,
        transformation_method: nil
      },
      'Date Range': {
        destination: 'b1g_date_range_drsim',
        delimited: true,
        transformation_method: nil
      },
      'Spatial Coverage': {
        destination: 'dct_spatial_sm',
        delimited: true,
        transformation_method: nil
      },
      'Geonames': {
        destination: 'b1g_geonames_sm',
        delimited: true,
        transformation_method: nil
      },
      'Bounding Box': {
        destination: 'solr_geom',
        delimited: false,
        transformation_method: nil
      },
      'Format': {
        destination: 'dc_format_s',
        delimited: false,
        transformation_method: nil
      },
      'Type': {
        destination: 'dc_type_sm',
        delimited: true,
        transformation_method: nil
      },
      'Geometry Type': {
        destination: 'layer_geom_type_s',
        delimited: false,
        transformation_method: nil
      },
      'Layer ID': {
        destination: 'layer_id_s',
        delimited: false,
        transformation_method: nil
      },
      'Documentation': {
        'destination': 'dct_references_s',
        'delimited': false,
        'transformation_method': 'build_dct_references'
      },
      'Download': {
         'destination': 'dct_references_s',
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'FeatureServer': {
         'destination': 'dct_references_s',
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'FGDC': {
         'destination': 'dct_references_s',
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'HTML': {
         'destination': 'dct_references_s',
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'IIIF': {
         'destination': 'dct_references_s',
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'ImageServer': {
         'destination': 'dct_references_s',
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'Information': {
         'destination': 'dct_references_s',
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'ISO19139': {
         'destination': 'dct_references_s',
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'Manifest': {
         'destination': 'dct_references_s',
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'MapServer': {
         'destination': 'dct_references_s',
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'MODS': {
         'destination': 'dct_references_s',
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'Index Map': {
         'destination': 'dct_references_s',
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'TileServer': {
         'destination': 'dct_references_s',
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'WFS': {
         'destination': 'dct_references_s',
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'WMS': {
         'destination': 'dct_references_s',
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'Image': {
        destination: 'b1g_image_ss',
        delimited: false,
        transformation_method: nil
      },
      'Identifier': {
        destination: 'dc_identifier_s',
        delimited: false,
        transformation_method: nil
      },
      'Slug': {
        destination: 'layer_slug_s',
        delimited: false,
        transformation_method: nil
      },
      'Provenance': {
        destination: 'dct_provenance_s',
        delimited: false,
        transformation_method: nil
      },
      'Code': {
        destination: 'b1g_code_s',
        delimited: false,
        transformation_method: nil
      },
      'Is Part Of': {
        destination: 'dct_isPartOf_sm',
        delimited: true,
        transformation_method: nil
      },
      'Source': {
        destination: 'dc_source_sm',
        delimited: true,
        transformation_method: nil
      },
      'Status': {
        destination: 'b1g_status_s',
        delimited: false,
        transformation_method: nil
      },
      'Accrual Method': {
        destination: 'dct_accrualMethod_s',
        delimited: false,
        transformation_method: nil
      },
      'Accrual Periodicity': {
        destination: 'dct_accrualPeriodicity_s',
        delimited: false,
        transformation_method: nil
      },
      'Date Accessioned': {
        destination: 'b1g_dateAccessioned_s',
        delimited: false,
        transformation_method: nil
      },
      'Date Retired': {
        destination: 'b1g_dateRetired_s',
        delimited: false,
        transformation_method: nil
      },
      'Rights': {
        destination: 'dc_rights_s',
        delimited: false,
        transformation_method: nil
      },
      'Access Rights': {
        destination: 'dct_accessRights_sm',
        delimited: true,
        transformation_method: nil
      },
      'Suppressed': {
        destination: 'suppressed_b',
        delimited: false,
        transformation_method: nil
      },
      'Child': {
        destination: 'b1g_child_record_b',
        delimited: false,
        transformation_method: nil
      }
    }
  end

  def dct_references_mappings
    {
      "Documentation": 'documentation_download',
      "Download": 'download',
      "FeatureServer": 'arcgis_feature_layer',
      "FGDC": 'metadata_fgdc',
      "HTML": 'metadata_html',
      "IIIF": 'iiif_image',
      "ImageServer": 'arcgis_image_map_layer',
      "Information": 'documentation_external',
      "ISO19139": 'metadata_iso',
      "Manifest": 'iiif_manifest',
      "MapServer": 'arcgis_dynamic_map_layer',
      "MODS": 'metadata_mods',
      "Index Map": 'open_index_map',
      "TileServer": 'arcgis_tiled_map_layer',
      "WFS": 'wfs',
      "WMS": 'wms',
      "WCS": 'wcs',
      "oEmbed": 'oembed',
      "Thumbnail": 'thumbnail',
      "Image": 'image'
    }
  end
end
