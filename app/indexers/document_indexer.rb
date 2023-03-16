# frozen_string_literal: true

# Solr indexing for our document class. Still a work in progress.
class DocumentIndexer < Kithe::Indexer
  configure do
    # Kithe
    to_field "model_pk_ssi", obj_extract("id") # the actual db pk, a UUID

    # GeoBlacklight
    to_field "gbl_mdVersion_s", literal("Aardvark")

    # to_field 'geomg_id_s', obj_extract('friendlier_id') # the actual db pk, a UUID

    # Define `to_field`(s) via Element
    Element.indexable.each do |elm|
      to_field elm.solr_field, obj_extract(elm.index_value)
    end

    to_field "gbl_mdModified_dt", obj_extract("gbl_mdModified_dt")

    # May want to switch to or add a 'date published' instead, right
    # now we only have date added to DB, which is what we had in sufia.
    to_field "date_created_dtsi" do |rec, _acc|
      rec.created_at.utc.iso8601 if rec&.created_at
    end

    to_field "date_modified_dtsi" do |rec, _acc|
      rec.updated_at.utc.iso8601 if rec&.updated_at
    end

    # - GEOMG
    to_field "b1g_geom_import_id_ssi", obj_extract("import_id")
  end
end
