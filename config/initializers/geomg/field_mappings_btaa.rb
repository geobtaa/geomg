# frozen_string_literal: true

# @TODO
# - Centroids
# - GeoNames
module Geomg
  module_function

  def field_mappings_btaa
    @mappings = Hash.new
    Element.importable.each do |elm|
      @mappings[elm.label.to_sym] = {
        destination: elm.solr_field,
        delimited: elm.repeatable,
        transformation_method: elm.import_transformation_method
      }
    end

    references = {
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
      'Harvard Download': {
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
      'oEmbed': {
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
      'WCS': {
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
      }
    }

    @mappings.merge(references)
  end

  def dct_references_mappings
    {
      "Documentation": 'documentation_download',
      "Download": 'download',
      "FeatureServer": 'arcgis_feature_layer',
      "FGDC": 'metadata_fgdc',
      "HTML": 'metadata_html',
      "Harvard Download": 'harvard_download',
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
