class CreateElements < ActiveRecord::Migration[6.1]
  def change
    create_table :elements do |t|
      t.string :label, null: false
      t.string :solr_schema_name, null: false
      t.string :field_definition
      t.string :placeholder_text
      t.string :data_entry_hint
      t.string :test_fixture_example

      t.string :field_type, null: false
      t.boolean :required, null: false, default: false
      t.boolean :repeatable, null: false, default: false

      t.string :controlled_vocabulary
      t.string :js_behaviors
      t.string :html_attributes
      t.boolean :display_only_on_persisted, null: false, default: false

      t.boolean :import_deliminated, null: false, default: false
      t.string :import_transformation_method
      t.string :export_transformation_method
      t.string :index_transformation_method
      t.string :validation_method

      t.timestamps
    end
  end
end
