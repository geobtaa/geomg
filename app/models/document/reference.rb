class Document
  class Reference
    # Via GBL Wiki
    # https://github.com/geoblacklight/geoblacklight/wiki/External-references
    REFERENCE_VALUES = {
      "wms": {
        label: "Web Mapping Service (WMS)",
        uri: "http://www.opengis.net/def/serviceType/ogc/wms"
      },
      "wfs": {
        label: "Web Feature Service (WFS)",
        uri: "http://www.opengis.net/def/serviceType/ogc/wfs"
      },
      "iiif_image": {
        label: "IIIF Image API",
        uri: "http://iiif.io/api/image"
      },
      "iiif_manifest": {
        label: "IIIF Manifest",
        uri: "http://iiif.io/api/presentation#manifest"
      },
      "download": {
        label: "Direct download file",
        uri: "http://schema.org/downloadUrl"
      },
      "documentation_download": {
        label: "Data dictionary / documentation download",
        uri: "http://lccn.loc.gov/sh85035852"
      },
      "documentation_external": {
        label: "Full layer description",
        uri: "http://schema.org/url"
      },
      "metadata_iso": {
        label: "Metadata in ISO 19139",
        uri: "http://www.isotc211.org/schemas/2005/gmd/"
      },
      "metadata_fgdc": {
        label: "Metadata in FGDC",
        uri: "http://www.opengis.net/cat/csw/csdgm"
      },
      "metadata_mods": {
        label: "Metadata in MODS",
        uri: "http://www.loc.gov/mods/v3"
      },
      "metadata_html": {
        label: "Metadata in HTML",
        uri: "http://www.w3.org/1999/xhtml"
      },
      "arcgis_feature_layer": {
        label: "ArcGIS FeatureLayer",
        uri: "urn:x-esri:serviceType:ArcGIS#FeatureLayer"
      },
      "arcgis_tiled_map_layer": {
        label: "ArcGIS TiledMapLayer",
        uri: "urn:x-esri:serviceType:ArcGIS#TiledMapLayer"
      },
      "arcgis_dynamic_map_layer": {
        label: "ArcGIS DynamicMapLayer",
        uri: "urn:x-esri:serviceType:ArcGIS#DynamicMapLayer"
      },
      "arcgis_image_map_layer": {
        label: "ArcGIS ImageMapLayer",
        uri: "urn:x-esri:serviceType:ArcGIS#ImageMapLayer"
      },
      "harvard": {
        label: "Harvard Geospatial Library Email Download",
        uri: "http://schema.org/DownloadAction"
      },
      "open_index_map": {
        label: "OpenIndexMap",
        uri: "https://openindexmaps.org"
      }
    }

    REFERENCE_URIS = REFERENCE_VALUES.collect{|key,value| value[:uri]}
    REFERENCE_LABELS = REFERENCE_VALUES.collect{|key,value| value[:label]}
    REFERENCE_LOOKUP = Hash[*(REFERENCE_VALUES.map{|key,value| [ value[:label], value[:uri]]}).flatten]

    include AttrJson::Model

    validates_presence_of :category, :value
    validates :category, inclusion:
      { in: REFERENCE_LABELS,
        allow_blank: true,
        message: "%{value} is not a valid category" }

    attr_json :category, :string
    attr_json :value, :string


    def self.lookup(arg)
      REFERENCE_LOOKUP[arg]
    end
  end
end
