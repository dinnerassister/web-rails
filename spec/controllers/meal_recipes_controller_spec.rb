require 'rails_helper'

RSpec.describe MealRecipesController, type: :controller do
  include Devise::TestHelpers

  describe "POST #add_recipe" do
    it "returns http success" do
      post :add_recipe, {:recipe_id => recipe.id}
      expect(response).to have_http_status(:success)
    end

    it "saves the meal plan recipe" do
      post :add_recipe, {:recipe_id => recipe.id}
      recipe_count = MealRecipe.where(user_id: user.id, recipe_id: recipe.id).count
      expect(recipe_count).to eq 1
    end

    it "does not save if recipe id is not a number" do
      recipe_id = "aaa"
      post :add_recipe, {:recipe_id => recipe_id}
      recipe_count = MealRecipe.where(user_id: user.id, recipe_id: recipe_id).count
      expect(recipe_count).to eq 0
    end

    it "does not save if recipe id doesn't exist" do
      recipe_id = recipe.id
      recipe.delete

      post :add_recipe, {:recipe_id => recipe.id}

      recipe_count = MealRecipe.where(user_id: user.id, recipe_id: recipe.id).count
      expect(recipe_count).to eq 0
    end

    it "returns a fail message when there is no recipe id" do
      post :add_recipe, {:recipe_id => "bad_id"}
      expect(response.body).to eq "Recipe id doesn't exist."
    end
  end

  describe "POST #delete_recipe" do
    it "returns http success" do
      post :delete_recipe, {:recipe_id => recipe.id}
      expect(response).to have_http_status(:success)
    end

    it "remove recipe from meal plan" do
      meal_plan_recipe = {user_id: user.id, recipe_id: recipe.id}
      meal = MealRecipe.create(meal_plan_recipe)

      post :delete_recipe, {:recipe_id => recipe.id}

      expect(meal.reload.active).to be false
    end
  end

  describe "POST #add" do
    it "returns http success" do
      post :add, {:recipe_ids => [recipe.id]}
      expect(response).to have_http_status(:success)
    end

    it "adds all the meal plan recipes" do
      recipe2 = RecipeFactory.create
      post :add, {:recipe_ids => [recipe.id, recipe2.id]}

      expect(MealRecipe.where({user_id: user.id, recipe_id: recipe.id}).count).to eq 1
      expect(MealRecipe.where({user_id: user.id, recipe_id: recipe2.id}).count).to eq 1
    end
  end

  describe "DELETE #delete" do
    it "returns http success" do
      post :delete, {:recipe_ids => [recipe.id]}
      expect(response).to have_http_status(:success)
    end

    it "removes all the meal plan recipes" do
      recipe2 = RecipeFactory.create
      meal1 = create_meal(recipe.id)
      meal2 = create_meal(recipe2.id)

      post :delete, {:recipe_ids => [recipe.id, recipe2.id]}

      expect(meal1.reload.active).to be false
      expect(meal2.reload.active).to be false
    end

    it "only remove recipe in the meal" do
      recipe2 = RecipeFactory.create
      meal1 = create_meal(recipe.id)
      meal2 = create_meal(recipe2.id)

      post :delete, {:recipe_ids => [recipe2.id]}

      expect(meal1.reload.active).to be true
      expect(meal2.reload.active).to be false
    end
  end

  def create_meal(recipe_id)
    MealRecipe.create(user_id: user.id, recipe_id: recipe_id)
  end

  before(:each) do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end

  let(:user) {UserFactory.create}
  let(:recipe) {RecipeFactory.create}
end
