require "singleton"

module Geomg
  class Schema
    def self.instance
      @instance ||= new
    end

    def elements
      @elements ||= Element.all
    end

    def solr_fields
      elements.map { |elm|
        [
          elm.label.parameterize(separator: "_").to_sym,
          elm.solr_field
        ]
      }.to_h
    end

    def importable_fields
      @fields = {}
      Element.importable.order(:position).each do |elm|
        @fields[elm.label.to_sym] = {
          destination: elm.solr_field,
          delimited: elm.repeatable,
          transformation_method: elm.import_transformation_method
        }
      end

      @fields = @fields.merge(dct_references_import_mappings)
      @fields
    end

    alias_method :field_mappings, :importable_fields

    def exportable_fields
      @fields = {}
      Element.exportable.order(:position).each do |elm|
        # Skip References
        next if elm.solr_field == "dct_references_s"
        @fields[elm.label.to_sym] = {
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

      @fields = @fields.merge(dct_references_import_mappings)
      @fields = @fields.merge(object_metadata)
      @fields
    end

    def dct_references_import_mappings
      {
        Documentation: {
          destination: solr_fields[:reference],
          delimited: false,
          transformation_method: "build_dct_references"
        },
        Download: {
          destination: solr_fields[:reference],
          delimited: false,
          transformation_method: "build_dct_references"
        },
        FeatureServer: {
          destination: solr_fields[:reference],
          delimited: false,
          transformation_method: "build_dct_references"
        },
        FGDC: {
          destination: solr_fields[:reference],
          delimited: false,
          transformation_method: "build_dct_references"
        },
        "Harvard Download": {
          destination: solr_fields[:reference],
          delimited: false,
          transformation_method: "build_dct_references"
        },
        HTML: {
          destination: solr_fields[:reference],
          delimited: false,
          transformation_method: "build_dct_references"
        },
        IIIF: {
          destination: solr_fields[:reference],
          delimited: false,
          transformation_method: "build_dct_references"
        },
        ImageServer: {
          destination: solr_fields[:reference],
          delimited: false,
          transformation_method: "build_dct_references"
        },
        Information: {
          destination: solr_fields[:reference],
          delimited: false,
          transformation_method: "build_dct_references"
        },
        ISO19139: {
          destination: solr_fields[:reference],
          delimited: false,
          transformation_method: "build_dct_references"
        },
        Manifest: {
          destination: solr_fields[:reference],
          delimited: false,
          transformation_method: "build_dct_references"
        },
        MapServer: {
          destination: solr_fields[:reference],
          delimited: false,
          transformation_method: "build_dct_references"
        },
        MODS: {
          destination: solr_fields[:reference],
          delimited: false,
          transformation_method: "build_dct_references"
        },
        oEmbed: {
          destination: solr_fields[:reference],
          delimited: false,
          transformation_method: "build_dct_references"
        },
        "Index Map": {
          destination: solr_fields[:reference],
          delimited: false,
          transformation_method: "build_dct_references"
        },
        TileServer: {
          destination: solr_fields[:reference],
          delimited: false,
          transformation_method: "build_dct_references"
        },
        WCS: {
          destination: solr_fields[:reference],
          delimited: false,
          transformation_method: "build_dct_references"
        },
        WFS: {
          destination: solr_fields[:reference],
          delimited: false,
          transformation_method: "build_dct_references"
        },
        WMS: {
          destination: solr_fields[:reference],
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
end
