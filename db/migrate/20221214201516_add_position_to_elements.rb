class AddPositionToElements < ActiveRecord::Migration[6.1]
  def change
    change_table :elements do |t|
      t.integer :position
    end
  end
end
