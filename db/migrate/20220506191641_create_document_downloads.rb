class CreateDocumentDownloads < ActiveRecord::Migration[6.1]
  def change
    create_table :document_downloads do |t|
      t.string :friendlier_id
      t.string :label
      t.string :value
      t.integer :position

      t.timestamps
    end
  end
end
