class CreateDocumentAccesses < ActiveRecord::Migration[6.0]
  def change
    create_table :document_accesses do |t|
      t.string :friendlier_id, null: false
      t.string :institution_code, null: false
      t.text :access_url, null: false

      t.timestamps
    end
  end
end
