class CreateMealPlanRecipes < ActiveRecord::Migration
  def change
    create_table :meal_plan_recipes do |t|
      t.integer :user_id, index: true, null: false
      t.integer :recipe_id
      t.datetime :last_used

      t.timestamps null: false
    end
  end
end
