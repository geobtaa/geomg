# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_200_807_211_555) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'pgcrypto'
  enable_extension 'plpgsql'

  create_function :kithe_models_friendlier_id_gen, sql_definition: <<-SQL
      CREATE OR REPLACE FUNCTION public.kithe_models_friendlier_id_gen(min_value bigint, max_value bigint)
       RETURNS text
       LANGUAGE plpgsql
      AS $function$
        DECLARE
          new_id_int bigint;
          new_id_str character varying := '';
          done bool;
          tries integer;
          alphabet char[] := ARRAY['0','1','2','3','4','5','6','7','8','9',
            'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n',
            'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'];
          alphabet_length integer := array_length(alphabet, 1);

        BEGIN
          done := false;
          tries := 0;
          WHILE (NOT done) LOOP
            tries := tries + 1;
            IF (tries > 3) THEN
              RAISE 'Could not find non-conflicting friendlier_id in 3 tries';
            END IF;

            new_id_int := trunc(random() * (max_value - min_value) + min_value);

            -- convert bigint to a Base-36 alphanumeric string
            -- see https://web.archive.org/web/20130420084605/http://www.jamiebegin.com/base36-conversion-in-postgresql/
            -- https://gist.github.com/btbytes/7159902
            WHILE new_id_int != 0 LOOP
              new_id_str := alphabet[(new_id_int % alphabet_length)+1] || new_id_str;
              new_id_int := new_id_int / alphabet_length;
            END LOOP;

            done := NOT exists(SELECT 1 FROM kithe_models WHERE friendlier_id=new_id_str);
          END LOOP;
          RETURN new_id_str;
        END;
        $function$
  SQL
  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness', unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'bookmarks', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.string 'user_type'
    t.string 'document_id'
    t.string 'document_type'
    t.binary 'title'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['document_id'], name: 'index_bookmarks_on_document_id'
    t.index ['user_id'], name: 'index_bookmarks_on_user_id'
  end

  create_table 'document_transitions', force: :cascade do |t|
    t.string 'to_state', null: false
    t.text 'metadata', default: '{}'
    t.integer 'sort_key', null: false
    t.uuid 'kithe_model_id', null: false
    t.boolean 'most_recent', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[kithe_model_id most_recent], name: 'index_document_transitions_parent_most_recent', unique: true, where: 'most_recent'
    t.index %w[kithe_model_id sort_key], name: 'index_document_transitions_parent_sort', unique: true
  end

  create_table 'import_transitions', force: :cascade do |t|
    t.string 'to_state', null: false
    t.text 'metadata', default: '{}'
    t.integer 'sort_key', null: false
    t.integer 'import_id', null: false
    t.boolean 'most_recent', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index %w[import_id most_recent], name: 'index_import_transitions_parent_most_recent', unique: true, where: 'most_recent'
    t.index %w[import_id sort_key], name: 'index_import_transitions_parent_sort', unique: true
  end

  create_table 'imports', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'source'
    t.text 'description'
    t.string 'filename'
    t.integer 'row_count'
    t.text 'headers', default: [], array: true
    t.string 'encoding'
    t.string 'content_type'
    t.string 'extension'
    t.boolean 'validity', default: false, null: false
    t.text 'validation_result'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'type'
    t.json 'import_log', default: {}
  end

  create_table 'kithe_derivatives', force: :cascade do |t|
    t.string 'key', null: false
    t.jsonb 'file_data'
    t.uuid 'asset_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[asset_id key], name: 'index_kithe_derivatives_on_asset_id_and_key', unique: true
    t.index ['asset_id'], name: 'index_kithe_derivatives_on_asset_id'
  end

  create_table 'kithe_model_contains', id: false, force: :cascade do |t|
    t.uuid 'containee_id'
    t.uuid 'container_id'
    t.index ['containee_id'], name: 'index_kithe_model_contains_on_containee_id'
    t.index ['container_id'], name: 'index_kithe_model_contains_on_container_id'
  end

  create_table 'kithe_models', id: :uuid, default: -> { 'gen_random_uuid()' }, force: :cascade do |t|
    t.string 'title', null: false
    t.string 'type', null: false
    t.integer 'position'
    t.jsonb 'json_attributes'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.uuid 'parent_id'
    t.string 'friendlier_id', default: -> { "kithe_models_friendlier_id_gen('2821109907456'::bigint, '101559956668415'::bigint)" }, null: false
    t.jsonb 'file_data'
    t.uuid 'representative_id'
    t.uuid 'leaf_representative_id'
    t.integer 'kithe_model_type', null: false
    t.bigint 'import_id'
    t.string 'publication_state', default: 'Draft'
    t.index ['friendlier_id'], name: 'index_kithe_models_on_friendlier_id', unique: true
    t.index ['import_id'], name: 'index_kithe_models_on_import_id'
    t.index ['leaf_representative_id'], name: 'index_kithe_models_on_leaf_representative_id'
    t.index ['parent_id'], name: 'index_kithe_models_on_parent_id'
    t.index ['representative_id'], name: 'index_kithe_models_on_representative_id'
  end

  create_table 'mappings', force: :cascade do |t|
    t.string 'source_header'
    t.string 'destination_field'
    t.boolean 'delimited'
    t.string 'transformation_method'
    t.bigint 'import_id', null: false
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.index ['import_id'], name: 'index_mappings_on_import_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', precision: 6, null: false
    t.datetime 'updated_at', precision: 6, null: false
    t.string 'invitation_token'
    t.datetime 'invitation_created_at'
    t.datetime 'invitation_sent_at'
    t.datetime 'invitation_accepted_at'
    t.integer 'invitation_limit'
    t.string 'invited_by_type'
    t.bigint 'invited_by_id'
    t.integer 'invitations_count', default: 0
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['invitation_token'], name: 'index_users_on_invitation_token', unique: true
    t.index ['invitations_count'], name: 'index_users_on_invitations_count'
    t.index ['invited_by_id'], name: 'index_users_on_invited_by_id'
    t.index %w[invited_by_type invited_by_id], name: 'index_users_on_invited_by_type_and_invited_by_id'
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  create_table 'versions', force: :cascade do |t|
    t.string 'item_type', null: false
    t.uuid 'item_id', null: false
    t.string 'event', null: false
    t.string 'whodunnit'
    t.text 'object'
    t.datetime 'created_at'
    t.text 'object_changes'
    t.index %w[item_type item_id], name: 'index_versions_on_item_type_and_item_id'
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'import_transitions', 'imports'
  add_foreign_key 'kithe_derivatives', 'kithe_models', column: 'asset_id'
  add_foreign_key 'kithe_model_contains', 'kithe_models', column: 'containee_id'
  add_foreign_key 'kithe_model_contains', 'kithe_models', column: 'container_id'
  add_foreign_key 'kithe_models', 'kithe_models', column: 'leaf_representative_id'
  add_foreign_key 'kithe_models', 'kithe_models', column: 'parent_id'
  add_foreign_key 'kithe_models', 'kithe_models', column: 'representative_id'
  add_foreign_key 'mappings', 'imports'
end
