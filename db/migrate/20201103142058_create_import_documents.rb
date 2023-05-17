class CreateImportDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :import_documents do |t|
      t.string :friendlier_id, null: false
      t.string :title, null: false
      t.json :json_attributes, default: "{}"
      t.references :import, null: false, foreign_key: true
      t.timestamps
    end

    remove_column :imports, :import_log, :json, default: {}
  end
end
