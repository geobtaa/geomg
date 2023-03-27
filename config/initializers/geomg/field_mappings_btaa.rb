# frozen_string_literal: true

# @TODO
# - Centroids
# - GeoNames
module Geomg
  module_function

  def importable_field_mappings
    @mappings = {}
    Element.importable.order(:position).each do |elm|
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
    @mappings = {}
    Element.exportable.order(:position).each do |elm|
      @mappings[elm.label.to_sym] = {
        destination: elm.solr_field,
        delimited: elm.repeatable,
        transformation_method: elm.export_transformation_method
      }
    end

    object_metadata = {
      "Created At": {
        destination: "created_at",
        delimited: false,
        transformation_method: nil
      },
      "Updated At": {
        destination: "updated_at",
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
      Documentation: {
        destination: Geomg::Schema.instance.solr_fields[:reference],
        delimited: false,
        transformation_method: "build_dct_references"
      },
      Download: {
        destination: Geomg::Schema.instance.solr_fields[:reference],
        delimited: false,
        transformation_method: "build_dct_references"
      },
      FeatureServer: {
        destination: Geomg::Schema.instance.solr_fields[:reference],
        delimited: false,
        transformation_method: "build_dct_references"
      },
      FGDC: {
        destination: Geomg::Schema.instance.solr_fields[:reference],
        delimited: false,
        transformation_method: "build_dct_references"
      },
      "Harvard Download": {
        destination: Geomg::Schema.instance.solr_fields[:reference],
        delimited: false,
        transformation_method: "build_dct_references"
      },
      HTML: {
        destination: Geomg::Schema.instance.solr_fields[:reference],
        delimited: false,
        transformation_method: "build_dct_references"
      },
      IIIF: {
        destination: Geomg::Schema.instance.solr_fields[:reference],
        delimited: false,
        transformation_method: "build_dct_references"
      },
      ImageServer: {
        destination: Geomg::Schema.instance.solr_fields[:reference],
        delimited: false,
        transformation_method: "build_dct_references"
      },
      Information: {
        destination: Geomg::Schema.instance.solr_fields[:reference],
        delimited: false,
        transformation_method: "build_dct_references"
      },
      ISO19139: {
        destination: Geomg::Schema.instance.solr_fields[:reference],
        delimited: false,
        transformation_method: "build_dct_references"
      },
      Manifest: {
        destination: Geomg::Schema.instance.solr_fields[:reference],
        delimited: false,
        transformation_method: "build_dct_references"
      },
      MapServer: {
        destination: Geomg::Schema.instance.solr_fields[:reference],
        delimited: false,
        transformation_method: "build_dct_references"
      },
      MODS: {
        destination: Geomg::Schema.instance.solr_fields[:reference],
        delimited: false,
        transformation_method: "build_dct_references"
      },
      oEmbed: {
        destination: Geomg::Schema.instance.solr_fields[:reference],
        delimited: false,
        transformation_method: "build_dct_references"
      },
      "Index Map": {
        destination: Geomg::Schema.instance.solr_fields[:reference],
        delimited: false,
        transformation_method: "build_dct_references"
      },
      TileServer: {
        destination: Geomg::Schema.instance.solr_fields[:reference],
        delimited: false,
        transformation_method: "build_dct_references"
      },
      WCS: {
        destination: Geomg::Schema.instance.solr_fields[:reference],
        delimited: false,
        transformation_method: "build_dct_references"
      },
      WFS: {
        destination: Geomg::Schema.instance.solr_fields[:reference],
        delimited: false,
        transformation_method: "build_dct_references"
      },
      WMS: {
        destination: Geomg::Schema.instance.solr_fields[:reference],
        delimited: false,
        transformation_method: "build_dct_references"
      }
    }
  end

  def dct_references_mappings
    {
      Documentation: "documentation_download",
      Download: "download",
      FeatureServer: "arcgis_feature_layer",
      FGDC: "metadata_fgdc",
      HTML: "metadata_html",
      "Harvard Download": "harvard_download",
      IIIF: "iiif_image",
      ImageServer: "arcgis_image_map_layer",
      Information: "documentation_external",
      ISO19139: "metadata_iso",
      Manifest: "iiif_manifest",
      MapServer: "arcgis_dynamic_map_layer",
      MODS: "metadata_mods",
      "Index Map": "open_index_map",
      TileServer: "arcgis_tiled_map_layer",
      WFS: "wfs",
      WMS: "wms",
      WCS: "wcs",
      oEmbed: "oembed",
      Thumbnail: "thumbnail",
      Image: "image"
    }
  end
end

Geomg.singleton_class.send(:alias_method, :field_mappings, :importable_field_mappings)
