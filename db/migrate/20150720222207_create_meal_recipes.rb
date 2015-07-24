class CreateMealRecipes < ActiveRecord::Migration
  def change
    create_table :meal_recipes do |t|
      t.integer :user_id, index: true, null: false
      t.integer :recipe_id, index: true, null: false
      t.datetime :last_used
      t.boolean :active, default: true

      t.timestamps null: false
    end
  end
end
