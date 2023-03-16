class CreateBulkActions < ActiveRecord::Migration[6.0]
  def change
    create_table :bulk_actions do |t|
      t.string :name
      t.string :scope, null: false # query
      t.string :field_name, null: false # field
      t.string :field_value, null: false # value
      t.text :notes
      t.jsonb :documents

      t.timestamps
    end
  end
end
