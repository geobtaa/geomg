class SerializeSchema < ActiveRecord::Migration[6.1]
  def change
    add_column :kithe_models, :elements, :text
  end
end
