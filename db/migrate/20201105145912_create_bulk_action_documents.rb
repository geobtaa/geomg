class CreateBulkActionDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :bulk_action_documents do |t|
      t.string  :friendlier_id, null: false
      t.integer :version, null: false
      t.references :bulk_action, null: false, foreign_key: true
      t.timestamps
    end

    remove_column :bulk_actions, :documents, :jsonb
  end
end
