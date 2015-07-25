require 'rails_helper'

RSpec.describe Meal do
  it "gets all the recipes in the meal" do
    meal = Meal.new(SecureRandom.uuid)
    recipes = create_meal(3, meal.id)
    expect(meal.recipes).to match_array(recipes)
  end

  def create_meal(size, meal_id)
    (0...size).map do |x|
      recipe = RecipeFactory.create(name: x.to_s)
      MealRecipe.create(user_id: 13, recipe_id: recipe.id, meal_id: meal_id)
    end
  end
end
