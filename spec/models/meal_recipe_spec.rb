require 'rails_helper'

RSpec.describe MealRecipe, type: :model do
  let (:attributes ) {{user_id: 1, recipe_id: 4}}

  it "prevents sql injection" do
    expect {MealRecipe.delete_recipes(1, "1) OR 1=1--")}.to raise_error
  end

  it "is active by default" do
    meal = MealRecipe.create(attributes)
    expect(meal.active).to be true
  end

  it "sets meal id" do
    meal = MealRecipe.create(attributes)
    expect(meal.meal_id).to_not be_nil
  end

  it "meal id remains the same upon update" do
    meal = MealRecipe.create(attributes)
    meal_id = meal.meal_id
    meal.update(user_id: 4)
    expect(meal.meal_id).to eq meal_id
  end

  it "sets meal id on add recipe" do
    MealRecipe.add_recipe(attributes[:user_id], attributes[:recipe_id])
    meal = MealRecipe.find_by(attributes)
    expect(meal.meal_id).to_not be_nil
  end
end
