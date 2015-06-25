require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  include Devise::TestHelpers

  describe "GET #index" do
    it "assigns all recipes as @recipes" do
      recipe = Recipe.create! valid_attributes
      get :index
      expect(assigns(:recipes)).to eq([recipe])
    end
  end

  describe "GET #show" do
    it "assigns the requested recipe as @recipe" do
      recipe = Recipe.create! valid_attributes
      get :show, {:id => recipe.to_param}, valid_session
      expect(assigns(:recipe)).to eq(recipe)
    end
  end

  describe "GET #new" do
    it "assigns a new recipe as @recipe" do
      get :new, {}, valid_session
      expect(assigns(:recipe)).to be_a_new(Recipe)
      expect(assigns(:recipe).ingredients.size).to eq 10
    end
  end

  describe "GET #edit" do
    it "assigns the requested recipe as @recipe" do
      recipe = Recipe.create! valid_attributes
      get :edit, {:id => recipe.to_param}, valid_session
      expect(assigns(:recipe)).to eq(recipe)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Recipe" do
        expect {
          post :create, {:recipe => valid_attributes}, valid_session
        }.to change(Recipe, :count).by(1)
      end

      it "assigns a newly created recipe as @recipe" do
        post :create, {:recipe => valid_attributes}, valid_session
        expect(assigns(:recipe)).to be_a(Recipe)
        expect(assigns(:recipe)).to be_persisted
      end

      it "redirects to the created recipe" do
        post :create, {:recipe => valid_attributes}, valid_session
        expect(response).to redirect_to(Recipe.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved recipe as @recipe" do
        post :create, {:recipe => invalid_attributes}, valid_session
        expect(assigns(:recipe)).to be_a_new(Recipe)
      end

      it "re-renders the 'new' template" do
        post :create, {:recipe => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end

    context "preparing data for database" do
      it "sets the user id" do
        post :create, {:recipe => valid_attributes}, valid_session
        expect(assigns(:recipe).user_id).to eq assigns(:current_user).id
      end

      it "does not save empty ingredients" do
        ingredients = {"0"=>{"name"=>"soy"}, 
                       "1"=>{"name"=>""}, 
                       "2"=>{"name"=>""}, 
                       "3"=>{"name"=>"sugar"},
                       "4"=>{"name"=>""}}

        params = valid_attributes.dup
        params["ingredients_attributes"] = ingredients

        post :create, {:recipe => params}, valid_session

        saved_ingredients = assigns(:recipe).ingredients.map {|i| i.name}

        expect(saved_ingredients).to match_array ["soy", "sugar"]
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {name: "Sugar", ingredients_attributes: {}}
      }

      it "updates the requested recipe" do
        recipe = Recipe.create! valid_attributes
        put :update, {:id => recipe.to_param, :recipe => new_attributes}, valid_session
        recipe.reload
        
      end

      it "assigns the requested recipe as @recipe" do
        recipe = Recipe.create! valid_attributes
        put :update, {:id => recipe.to_param, :recipe => valid_attributes}, valid_session
        expect(assigns(:recipe)).to eq(recipe)
      end

      it "redirects to the recipe" do
        recipe = Recipe.create! valid_attributes
        put :update, {:id => recipe.to_param, :recipe => valid_attributes}, valid_session
        expect(response).to redirect_to(recipe)
      end
    end

    context "with invalid params" do
      it "assigns the recipe as @recipe" do
        recipe = Recipe.create! valid_attributes
        put :update, {:id => recipe.to_param, :recipe => invalid_attributes}, valid_session
        expect(assigns(:recipe)).to eq(recipe)
      end

      it "re-renders the 'edit' template" do
        recipe = Recipe.create! valid_attributes
        put :update, {:id => recipe.to_param, :recipe => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested recipe" do
      recipe = Recipe.create! valid_attributes
      expect {
        delete :destroy, {:id => recipe.to_param}, valid_session
      }.to change(Recipe, :count).by(-1)
    end

    it "redirects to the recipes list" do
      recipe = Recipe.create! valid_attributes
      delete :destroy, {:id => recipe.to_param}, valid_session
      expect(response).to redirect_to(recipes_url)
    end
  end

  before(:each) do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    sign_in UserFactory.create
  end

  let(:valid_attributes) {
    {"name"=>"tofu", 
      "ingredients_attributes"=>{"0"=>{"name"=>"soy"}, "1"=>{"name"=>"milk"}}, 
      "directions"=>"buy from store \n cook at home", 
      "prep_time"=>"3", 
      "cook_time"=>"10", 
      "source_url"=>"http://food.com", 
      "serving"=>"3"}
  }

  let(:invalid_attributes) {
    {name: "", ingredients_attributes: {}}
  }

  let(:valid_session) { {} }
end
