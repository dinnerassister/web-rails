require 'rails_helper'
require 'recipes/meal_plan_generator'

RSpec.describe MealPlanGenerator do
  let(:generator) { MealPlanGenerator }
  let(:user_id) { 8923 }
  let(:start_date) {Date.new}
  let(:end_date) {start_date + 3.days}

  xit "create a meal plan for the user" do
    meals = create_meal(3)
    plan = generator.create(user_id, start_date, end_date)
    expect(plan.meals).to eq []
  end

  def create_meal(size)
    (0...size).map do |x|
      recipe = RecipeFactory.create(name: x.to_s)
      MealRecipe.create(user_id: user_id, recipe_id: recipe.id)
    end
  end
end

