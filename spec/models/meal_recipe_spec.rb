require 'rails_helper'

RSpec.describe MealRecipe, type: :model do
  it "prevents sql injection" do
    expect {MealRecipe.delete_recipes(1, "1) OR 1=1--")}.to raise_error
  end

  it "is active by default" do
    meal = MealRecipe.create(user_id: 1, recipe_id: 4)
    expect(meal.active).to be true
  end
end
