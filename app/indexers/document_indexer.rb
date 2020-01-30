# Solr indexing for our document class. Still a work in progress.
class DocumentIndexer < Kithe::Indexer
  configure do
    # Kithe
    to_field "model_pk_ssi", obj_extract("id") # the actual db pk, a UUID

    # GeoBlacklight
    to_field "geoblacklight_version", literal("1.0")

    to_field "dc_description_s", obj_extract("dc_description_s")
    to_field "dc_format_s", obj_extract("dc_format_s")
    to_field "dc_identifier_s", obj_extract("dc_identifier_s")
    to_field "dc_language_sm", obj_extract("dc_language_sm")
    to_field "dc_rights_s", obj_extract("dc_rights_s")
    to_field "dc_title_s", obj_extract("title")
    to_field "dc_type_sm", obj_extract("dc_type_sm")
    to_field "dct_isPartOf_sm", obj_extract("dct_isPartOf_sm")
    to_field "dct_provenance_s", obj_extract("dct_provenance_s")
    to_field "dct_references_s", obj_extract("references_json")
    to_field "dct_spatial_sm", obj_extract("dct_spatial_sm")
    to_field "dct_temporal_sm", obj_extract("dct_temporal_sm")
    to_field "layer_geom_type_s", obj_extract("layer_geom_type_s")
    to_field "layer_modified_dt" do |rec, acc|
      if rec.updated_at
        acc << rec.updated_at.utc.iso8601
      end
    end
    to_field "layer_slug_s", obj_extract("layer_slug_s")
    to_field "solr_geom", obj_extract("solr_geom")
    to_field "solr_year_i", obj_extract("solr_year_i")

    # B1G
    to_field "b1g_centroid_ss", obj_extract("b1g_centroid_ss")
    to_field "b1g_code_s", obj_extract("b1g_code_s")
    to_field "b1g_dateAccessioned_s", obj_extract("b1g_dateAccessioned_s")
    to_field "b1g_date_range_drsim", obj_extract("b1g_date_range_drsim")
    to_field "b1g_genre_sm", obj_extract("b1g_genre_sm")
    to_field "b1g_image_ss", obj_extract("b1g_image_ss")
    to_field "b1g_keyword_sm", obj_extract("b1g_keyword_sm")
    to_field "b1g_status_s", obj_extract("b1g_status_s")

    # TODO
    # suppressed_b

    # May want to switch to or add a 'date published' instead, right
    # now we only have date added to DB, which is what we had in sufia.
    to_field "date_created_dtsi" do |rec, acc|
      if rec.created_at
        acc << rec.created_at.utc.iso8601
      end
    end

    to_field "date_modified_dtsi" do |rec, acc|
      if rec.updated_at
        acc << rec.updated_at.utc.iso8601
      end
    end
  end
end
