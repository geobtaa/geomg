# frozen_string_literal: true

# @TODO
# - Centroids
# - GeoNames
module Geomg
  module_function

  def importable_field_mappings
    @mappings = Hash.new
    Element.importable.each do |elm|
      @mappings[elm.label.to_sym] = {
        destination: elm.solr_field,
        delimited: elm.repeatable,
        transformation_method: elm.import_transformation_method
      }
    end

    @mappings = @mappings.merge(dct_references_import_mappings)
    @mappings
  end

  def exportable_field_mappings
    @mappings = Hash.new
    Element.exportable.each do |elm|
      @mappings[elm.label.to_sym] = {
        destination: elm.solr_field,
        delimited: elm.repeatable,
        transformation_method: elm.export_transformation_method
      }
    end

    object_metadata = {
      'Created At': {
        destination: 'created_at',
        delimited: false,
        transformation_method: nil
      },
      'Updated At': {
        destination: 'updated_at',
        delimited: false,
        transformation_method: nil
      }
    }

    @mappings = @mappings.merge(dct_references_import_mappings)
    @mappings = @mappings.merge(object_metadata)
    @mappings
  end

  def dct_references_import_mappings
    {
      'Documentation': {
        'destination': GEOMG_SOLR_FIELDS[:reference],
        'delimited': false,
        'transformation_method': 'build_dct_references'
      },
      'Download': {
         'destination': GEOMG_SOLR_FIELDS[:reference],
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'FeatureServer': {
         'destination': GEOMG_SOLR_FIELDS[:reference],
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'FGDC': {
         'destination': GEOMG_SOLR_FIELDS[:reference],
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'Harvard Download': {
         'destination': GEOMG_SOLR_FIELDS[:reference],
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'HTML': {
         'destination': GEOMG_SOLR_FIELDS[:reference],
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'IIIF': {
         'destination': GEOMG_SOLR_FIELDS[:reference],
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'ImageServer': {
         'destination': GEOMG_SOLR_FIELDS[:reference],
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'Information': {
         'destination': GEOMG_SOLR_FIELDS[:reference],
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'ISO19139': {
         'destination': GEOMG_SOLR_FIELDS[:reference],
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'Manifest': {
         'destination': GEOMG_SOLR_FIELDS[:reference],
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'MapServer': {
         'destination': GEOMG_SOLR_FIELDS[:reference],
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'MODS': {
         'destination': GEOMG_SOLR_FIELDS[:reference],
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'oEmbed': {
         'destination': GEOMG_SOLR_FIELDS[:reference],
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'Index Map': {
         'destination': GEOMG_SOLR_FIELDS[:reference],
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'TileServer': {
         'destination': GEOMG_SOLR_FIELDS[:reference],
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'WCS': {
         'destination': GEOMG_SOLR_FIELDS[:reference],
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'WFS': {
         'destination': GEOMG_SOLR_FIELDS[:reference],
         'delimited': false,
         'transformation_method': 'build_dct_references'
      },
      'WMS': {
         'destination': GEOMG_SOLR_FIELDS[:reference],
         'delimited': false,
         'transformation_method': 'build_dct_references'
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

Geomg.singleton_class.send(:alias_method, :field_mappings, :importable_field_mappings)
