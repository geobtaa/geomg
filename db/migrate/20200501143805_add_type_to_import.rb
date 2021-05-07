# frozen_string_literal: true

# Add Type to Import
class AddTypeToImport < ActiveRecord::Migration[6.0]
  def change
    add_column :imports, :type, :string
  end
end
