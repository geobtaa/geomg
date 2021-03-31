# frozen_string_literal: true

# @TODO
# - Centroids
# - GeoNames
module Geomg
  module_function

  def field_mappings_btaa
    {
      'Title': {
        destination: GEOMG.FIELDS.TITLE,
        delimited: false,
        transformation_method: nil
      },
      'Alternative Title': {
        destination: GEOMG.FIELDS.ALT_TITLE,
        delimited: true,
        transformation_method: nil
      },
      'Description': {
        destination: GEOMG.FIELDS.DESCRIPTION,
        delimited: false,
        transformation_method: nil
      },
      'Language': {
        destination: GEOMG.FIELDS.LANGUAGE,
        delimited: true,
        transformation_method: nil
      },
      'Publisher': {
        destination: GEOMG.FIELDS.PUBLISHER,
        delimited: true,
        transformation_method: nil
      },
      'Creator': {
        destination: GEOMG.FIELDS.CREATOR,
        delimited: true,
        transformation_method: nil
      },
      'Genre': {
        destination: GEOMG.FIELDS.B1G_GENRE,
        delimited: true,
        transformation_method: nil
      },
      'Subject': {
        destination: GEOMG.FIELDS.SUBJECT,
        delimited: true,
        transformation_method: nil
      },
      'Keyword': {
        destination: GEOMG.FIELDS.B1G_KEYWORD,
        delimited: true,
        transformation_method: nil
      },
      'Date Issued': {
        destination: GEOMG.FIELDS.ISSUED,
        delimited: false,
        transformation_method: nil
      },
      'Temporal Coverage': {
        destination: GEOMG.FIELDS.TEMPORAL,
        delimited: true,
        transformation_method: nil
      },
      'Date Range': {
        destination: GEOMG.FIELDS.B1G_DATE_RANGE,
        delimited: true,
        transformation_method: nil
      },
      'Spatial Coverage': {
        destination: GEOMG.FIELDS.SPATIAL,
        delimited: true,
        transformation_method: nil
      },
      'Geonames': {
        destination: GEOMG.FIELDS.B1G_GEONAMES,
        delimited: true,
        transformation_method: nil
      },
      'Bounding Box': {
        destination: GEOMG.FIELDS.GEOM,
        delimited: false,
        transformation_method: nil
      },
      'Format': {
        destination: GEOMG.FIELDS.FORMAT,
        delimited: false,
        transformation_method: nil
      },
      'Type': {
        destination: GEOMG.FIELDS.TYPE,
        delimited: true,
        transformation_method: nil
      },
      'Geometry Type': {
        destination: GEOMG.FIELDS.LAYER_GEOM_TYPE,
        delimited: false,
        transformation_method: nil
      },
      'Layer ID': {
        destination: GEOMG.FIELDS.LAYER_ID,
        delimited: false,
        transformation_method: nil
      },
      'Documentation': {
        'destination': GEOMG.FIELDS.REFERENCES,
        'delimited': false,
        'transformation_method': 'build_dct_references'
      },
      'Download': {
         'destination': GEOMG.FIELDS.REFERENCES,
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'FeatureServer': {
         'destination': GEOMG.FIELDS.REFERENCES,
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'FGDC': {
         'destination': GEOMG.FIELDS.REFERENCES,
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'HTML': {
         'destination': GEOMG.FIELDS.REFERENCES,
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'IIIF': {
         'destination': GEOMG.FIELDS.REFERENCES,
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'ImageServer': {
         'destination': GEOMG.FIELDS.REFERENCES,
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'Information': {
         'destination': GEOMG.FIELDS.REFERENCES,
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'ISO19139': {
         'destination': GEOMG.FIELDS.REFERENCES,
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'Manifest': {
         'destination': GEOMG.FIELDS.REFERENCES,
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'MapServer': {
         'destination': GEOMG.FIELDS.REFERENCES,
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'MODS': {
         'destination': GEOMG.FIELDS.REFERENCES,
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'Index Map': {
         'destination': GEOMG.FIELDS.REFERENCES,
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'TileServer': {
         'destination': GEOMG.FIELDS.REFERENCES,
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'WFS': {
         'destination': GEOMG.FIELDS.REFERENCES,
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'WMS': {
         'destination': GEOMG.FIELDS.REFERENCES,
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'Image': {
        destination: GEOMG.FIELDS.B1G_IMAGE,
        delimited: false,
        transformation_method: nil
      },
      'Identifier': {
        destination: GEOMG.FIELDS.IDENTIFIER,
        delimited: false,
        transformation_method: nil
      },
      'Slug': {
        destination: GEOMG.FIELDS.LAYER_SLUG,
        delimited: false,
        transformation_method: nil
      },
      'Provenance': {
        destination: GEOMG.FIELDS.PROVENANCE,
        delimited: false,
        transformation_method: nil
      },
      'Code': {
        destination: GEOMG.FIELDS.B1G_CODE,
        delimited: false,
        transformation_method: nil
      },
      'Is Part Of': {
        destination: GEOMG.FIELDS.IS_PART_OF,
        delimited: true,
        transformation_method: nil
      },
      'Source': {
        destination: GEOMG.FIELDS.SOURCE,
        delimited: true,
        transformation_method: nil
      },
      'Status': {
        destination: GEOMG.FIELDS.B1G_STATUS,
        delimited: false,
        transformation_method: nil
      },
      'Accrual Method': {
        destination: GEOMG.FIELDS.ACCRUAL_METHOD,
        delimited: false,
        transformation_method: nil
      },
      'Accrual Periodicity': {
        destination: GEOMG.FIELDS.ACCRUAL_PERIODICITY,
        delimited: false,
        transformation_method: nil
      },
      'Date Accessioned': {
        destination: GEOMG.FIELDS.B1G_DATE_ACCESSIONED,
        delimited: false,
        transformation_method: nil
      },
      'Date Retired': {
        destination: GEOMG.FIELDS.B1G_DATE_RETIRED,
        delimited: false,
        transformation_method: nil
      },
      'Rights': {
        destination: GEOMG.FIELDS.RIGHTS,
        delimited: false,
        transformation_method: nil
      },
      'Access Rights': {
        destination: GEOMG.FIELDS.ACCESS_RIGHTS,
        delimited: true,
        transformation_method: nil
      },
      'Suppressed': {
        destination: GEOMG.FIELDS.SUPPRESSED,
        delimited: false,
        transformation_method: nil
      },
      'Child': {
        destination: GEOMG.FIELDS.B1G_CHILD_RECORD,
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
