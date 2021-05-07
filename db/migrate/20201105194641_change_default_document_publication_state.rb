class ChangeDefaultDocumentPublicationState < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:kithe_models, :publication_state, from: 'Draft', to: 'draft')
  end
end
