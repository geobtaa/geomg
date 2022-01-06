class CreateBlazerUploads < ActiveRecord::Migration[6.1]
  def change
    create_table :blazer_uploads do |t|
      t.references :creator
      t.string :table
      t.text :description
      t.timestamps null: false
    end

    execute "CREATE SCHEMA blazer_uploads"
  end
end
