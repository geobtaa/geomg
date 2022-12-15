class CreateFormElements < ActiveRecord::Migration[6.1]
  def change
    create_table :form_elements do |t|
      t.string :type, null: false
      t.string :label
      t.integer :element_id, null: true
      t.integer :position

      t.timestamps
    end
  end
end
