# frozen_string_literal: true

class AddPublicationStateToDocument < ActiveRecord::Migration[6.0]
  def change
    add_column :kithe_models, :publication_state, :string, default: "Draft"
  end
end
