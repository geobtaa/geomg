class AddIdToBulkActionDocuments < ActiveRecord::Migration[6.0]
  def change
    add_column :bulk_action_documents, :document_id, :uuid
  end
end
