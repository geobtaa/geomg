# frozen_string_literal: true

class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.integer :user_id, index: true, null: false
      t.string :user_type
      t.string :document_id, index: true
      t.string :document_type
      t.binary :title
      t.timestamps
    end
  end
end
