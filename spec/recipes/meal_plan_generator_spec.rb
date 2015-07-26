require 'rails_helper'
require 'recipes/meal_plan_generator'
require 'helpers/meal_factory'

RSpec.describe MealPlanGenerator do
  let(:generator) { MealPlanGenerator }
  let(:user_id) { 8923 }
  let(:size) { 3 }
  let(:start_date) {Date.today}
  #days are inclusive so to get 3 days, you should add 2 more days
  let(:end_date) {start_date + (size - 1).days}

  it "create a meal plan for the user" do
    meals = MealFactory.create_meals_for(user_id, size)
    plan = generator.create(user_id, start_date, end_date)
    expect(meal_ids(plan.meals)).to match_array(meal_ids(meals))
  end

  it "returns meals the size of the plan" do
    meals = MealFactory.create_meals_for(user_id, size - 1)
    plan = generator.create(user_id, start_date, end_date)
    expect(plan.meals.size).to eq size
    expect(meal_ids(plan.meals).uniq).to match_array(meal_ids(meals))
  end

  it "returns meals that hasn't been used recently" do
    meals = MealFactory.create_meals_for(user_id, size + 1)

    today_meal = meals.first
    today_meal.update(last_used: Date.today)

    last_week = meals[1]
    last_week.update(last_used: 1.week.ago)

    plan = generator.create(user_id, start_date, end_date)

    expect(meal_ids(plan.meals)).to_not include(today_meal.id)
  end

  def meal_ids(meals)
    meals.map{ |m| m.id }
  end
end

