require 'rails_helper'
require 'recipes/meal_plan_generator'
require 'helpers/meal_factory'

RSpec.describe MealPlanGenerator do
  let(:generator) { MealPlanGenerator }
  let(:user_id) { 8923 }
  let(:start_date) {Date.new}
  let(:end_date) {start_date + 3.days}

  it "create a meal plan for the user" do
    meals = MealFactory.create_meals_for(user_id, 3)
    plan = generator.create(user_id, start_date, end_date)
    expect(plan.meals).to match_array(meals)
  end
end

