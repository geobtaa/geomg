class AddImportToDocument < ActiveRecord::Migration[6.0]
  def change
    add_reference :kithe_models, :import
  end
end
