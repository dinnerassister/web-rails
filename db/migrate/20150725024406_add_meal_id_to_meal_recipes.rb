class AddMealIdToMealRecipes < ActiveRecord::Migration
  def change
    add_column :meal_recipes, :meal_id, :string, index: true
  end
end
