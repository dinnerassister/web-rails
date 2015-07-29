class AddFieldsToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :item, :string
    add_column :ingredients, :quantity, :integer
    add_column :ingredients, :unit, :string
    add_column :ingredients, :description, :string
  end
end
