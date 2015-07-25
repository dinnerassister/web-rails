require 'rails_helper'
require 'helpers/meal_factory'

RSpec.describe Meal do
  it "gets all the recipes in the meal" do
    meal = Meal.new(SecureRandom.uuid)
    recipes = MealFactory.create_recipes_for(meal.id, 3)
    expect(meal.recipes).to match_array(recipes)
  end

  it "only retrieves recipes with the specify meal id" do
    meal = Meal.new(SecureRandom.uuid)
    recipe1 = MealFactory.create_recipes_for(meal.id, 1)
    recipe2 = MealFactory.create_recipes_for(SecureRandom.uuid, 1)

    expect(meal.recipes).to match_array(recipe1)
  end

  it "has a photo" do
    meal = Meal.new(SecureRandom.uuid)
    recipes = MealFactory.create_recipes_for(meal.id, 2)

    expect(meal.photo).to_not be_nil
  end
end
