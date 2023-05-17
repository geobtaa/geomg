# frozen_string_literal: true

# Document
class Document
  # Reference
  class Reference
    # Via GBL Wiki
    # https://github.com/geoblacklight/geoblacklight/wiki/External-references
    REFERENCE_VALUES = {
      wcs: {
        label: "Web Coverage Service (WCS)",
        uri: "http://www.opengis.net/def/serviceType/ogc/wcs"
      },
      wms: {
        label: "Web Mapping Service (WMS)",
        uri: "http://www.opengis.net/def/serviceType/ogc/wms"
      },
      wfs: {
        label: "Web Feature Service (WFS)",
        uri: "http://www.opengis.net/def/serviceType/ogc/wfs"
      },
      iiif_image: {
        label: "IIIF Image API",
        uri: "http://iiif.io/api/image"
      },
      iiif_manifest: {
        label: "IIIF Manifest",
        uri: "http://iiif.io/api/presentation#manifest"
      },
      image: {
        label: "Image file",
        uri: "http://schema.org/image"
      },
      download: {
        label: "Direct download file",
        uri: "http://schema.org/downloadUrl"
      },
      thumbnail: {
        label: "Thumbnail file",
        uri: "http://schema.org/thumbnailUrl"
      },
      documentation_download: {
        label: "Data dictionary / documentation download",
        uri: "http://lccn.loc.gov/sh85035852"
      },
      documentation_external: {
        label: "Full layer description",
        uri: "http://schema.org/url"
      },
      metadata_iso: {
        label: "Metadata in ISO 19139",
        uri: "http://www.isotc211.org/schemas/2005/gmd/"
      },
      metadata_fgdc: {
        label: "Metadata in FGDC",
        uri: "http://www.opengis.net/cat/csw/csdgm"
      },
      metadata_mods: {
        label: "Metadata in MODS",
        uri: "http://www.loc.gov/mods/v3"
      },
      metadata_html: {
        label: "Metadata in HTML",
        uri: "http://www.w3.org/1999/xhtml"
      },
      arcgis_feature_layer: {
        label: "ArcGIS FeatureLayer",
        uri: "urn:x-esri:serviceType:ArcGIS#FeatureLayer"
      },
      arcgis_tiled_map_layer: {
        label: "ArcGIS TiledMapLayer",
        uri: "urn:x-esri:serviceType:ArcGIS#TiledMapLayer"
      },
      arcgis_dynamic_map_layer: {
        label: "ArcGIS DynamicMapLayer",
        uri: "urn:x-esri:serviceType:ArcGIS#DynamicMapLayer"
      },
      arcgis_image_map_layer: {
        label: "ArcGIS ImageMapLayer",
        uri: "urn:x-esri:serviceType:ArcGIS#ImageMapLayer"
      },
      harvard_download: {
        label: "Harvard Download",
        uri: "http://schema.org/DownloadAction"
      },
      open_index_map: {
        label: "OpenIndexMap",
        uri: "https://openindexmaps.org"
      },
      oembed: {
        label: "oEmbed",
        uri: "https://oembed.com"
      }
    }.freeze

    include AttrJson::Model

    validates :category, :value, presence: true
    validates :category, inclusion:
      {in: REFERENCE_VALUES.stringify_keys.keys,
       allow_blank: true,
       message: "%<value>s is not a valid category"}

    attr_json :category, :string
    attr_json :value, :string
  end
end
