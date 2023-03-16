class ElementsSerializeHtmlAttributes < ActiveRecord::Migration[6.1]
  def change
    change_column :elements, :html_attributes, :text
  end
end
