# frozen_string_literal: true

# Add Mappings
class CreateMappings < ActiveRecord::Migration[6.0]
  def change
    create_table :mappings do |t|
      t.string :source_header
      t.string :destination_field
      t.boolean :delimited
      t.string :transformation_method
      t.references :import, null: false, foreign_key: true

      t.timestamps
    end
  end
end
