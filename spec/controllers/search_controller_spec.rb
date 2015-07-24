require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  include Devise::TestHelpers

  describe "GET #user" do
    it "returns http success" do
      get :user
      expect(response).to have_http_status(:success)
    end

    it "returns recipe sorted by last added" do
      recipe1 = RecipeFactory.create({user_id: user.id})
      recipe2 = RecipeFactory.create({user_id: user.id})

      get :user

      expect(assigns(:recipes)).to eq [recipe2, recipe1]
    end

    it "gets the recipe_ids" do
      r1 = MealRecipe.create(user_id: user.id, recipe_id: 34);
      r2 = MealRecipe.create(user_id: user.id, recipe_id: 57);

      get :user

      expect(assigns(:recipes_in_meal_plan)).to eq [r1.recipe_id, r2.recipe_id]
    end

    it "gets the recipe_ids for signed in user" do
      r1 = MealRecipe.create(user_id: user.id, recipe_id: 34);
      r2 = MealRecipe.create(user_id: user.id + 4, recipe_id: 57);

      get :user

      expect(assigns(:recipes_in_meal_plan)).to eq [r1.recipe_id]
    end

    it "recipe ids are unique" do
      r1 = MealRecipe.create(user_id: user.id, recipe_id: 57);
      r2 = MealRecipe.create(user_id: user.id, recipe_id: 57);

      get :user

      expect(assigns(:recipes_in_meal_plan)).to eq [r1.recipe_id]
    end
  end


  before(:each) do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  let(:user) {UserFactory.create}
  let(:recipe) {RecipeFactory.create}
end
