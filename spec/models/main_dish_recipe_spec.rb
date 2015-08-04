require 'rails_helper'

RSpec.describe MainDishRecipe, type: :model do
  let (:attributes ) {{user_id: 1, recipe_id: 4}}

  it "prevents sql injection" do
    expect {MainDishRecipe.delete_recipes(1, "1) OR 1=1--")}.to raise_error
  end

  it "is active by default" do
    meal = MainDishRecipe.create(attributes)
    expect(meal.active).to be true
  end
end
