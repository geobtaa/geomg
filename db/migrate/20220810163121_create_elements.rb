class CreateElements < ActiveRecord::Migration[6.1]
  def change
    create_table :elements do |t|
      t.string :label, null: false
      t.string :solr_field, null: false
      t.string :field_definition

      # HTML
      t.string :field_type, null: false
      t.boolean :required, null: false, default: false
      t.boolean :repeatable, null: false, default: false
      t.boolean :formable, null: false, default: true
      t.string :placeholder_text
      t.string :data_entry_hint
      t.string :test_fixture_example
      t.string :controlled_vocabulary
      t.string :js_behaviors
      t.string :html_attributes
      t.boolean :display_only_on_persisted, null: false, default: false

      # Import/Export/Index
      t.boolean :importable, null: false, default: true
      t.boolean :import_deliminated, null: false, default: false
      t.string :import_transformation_method

      t.boolean :exportable, null: false, default: true
      t.string :export_transformation_method

      t.boolean :indexable, null: false, default: true
      t.string :index_transformation_method

      # Data Validation
      t.string :validation_method

      t.timestamps
    end
  end
end
