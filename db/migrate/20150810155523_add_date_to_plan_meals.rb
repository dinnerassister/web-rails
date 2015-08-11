class AddDateToPlanMeals < ActiveRecord::Migration
  def change
    add_column :plan_meals, :meal_date, :date
  end
end
