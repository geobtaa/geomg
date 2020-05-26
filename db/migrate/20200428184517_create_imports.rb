class CreateImports < ActiveRecord::Migration[6.0]
  def change
    create_table :imports do |t|
      # Metadata
      t.string :name, null: false
      t.string :source
      t.text :description

      # Filedata
      t.string :filename
      t.integer :row_count
      t.text :headers, array: true, default: []
      t.string :encoding
      t.string :content_type
      t.string :extension
      t.boolean :validity, null: false, default: false
      t.text :validation_result

      t.timestamps
    end
  end
end
