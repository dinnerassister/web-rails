class CreatePlanMeals < ActiveRecord::Migration
  def change
    create_table :plan_meals do |t|
      t.integer :plan_id, index: true, null: false
      t.integer :meal_id, index: true, null: false

      t.timestamps null: false
    end
  end
end
