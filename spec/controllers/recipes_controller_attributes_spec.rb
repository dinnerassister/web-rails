require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  include Devise::TestHelpers
    let (:recipe) {Recipe.create(name: "old name", directions: "old directons")}
    let(:attributes) {{ "name"=>"tofu", 
                        "directions"=>"buy from store \n cook at home", 
                        "prep_time"=>"3", 
                        "cook_time"=>"10", 
                        "source_url"=>"http://food.com",
                        "serving"=>"3"}
                    }

  describe "singular attributes" do
    it "saves name" do
      post :create, {:recipe => attributes}, valid_session
      recipe = assigns(:recipe)

      expect(recipe.name).to eq(attributes["name"])
      expect(recipe.directions).to eq(attributes["directions"])
      expect(recipe.prep_time).to eq(attributes["prep_time"].to_i)
      expect(recipe.cook_time).to eq(attributes["cook_time"].to_i)
      expect(recipe.source_url).to eq(attributes["source_url"])
      expect(recipe.serving).to eq(attributes["serving"].to_i)
    end

    context "update" do
      it "updates name" do
        new_attributes = attributes.merge(name: "Ice cream")
        put :update, {:id => recipe.to_param, :recipe => new_attributes}, valid_session
        recipe.reload

        expect(recipe.name).to eq new_attributes[:name]
      end

      it "updates directions" do
        new_attributes = attributes.merge(directions: "mix water")
        put :update, {:id => recipe.to_param, :recipe => new_attributes}, valid_session
        recipe.reload

        expect(recipe.directions).to eq new_attributes[:directions]
      end

      it "updates prep_time" do
        new_attributes = attributes.merge(prep_time: "5")
        put :update, {:id => recipe.to_param, :recipe => new_attributes}, valid_session
        recipe.reload

        expect(recipe.prep_time).to eq new_attributes[:prep_time].to_i
      end

      it "updates cook_time" do
        new_attributes = attributes.merge(cook_time: "30")
        put :update, {:id => recipe.to_param, :recipe => new_attributes}, valid_session
        recipe.reload

        expect(recipe.cook_time).to eq new_attributes[:cook_time].to_i
      end

      it "updates serving" do
        new_attributes = attributes.merge(serving: "9")
        put :update, {:id => recipe.to_param, :recipe => new_attributes}, valid_session
        recipe.reload

        expect(recipe.serving).to eq new_attributes[:serving].to_i
      end

      it "updates source_url" do
        new_attributes = attributes.merge(source_url: "http://allrecipes.com")
        put :update, {:id => recipe.to_param, :recipe => new_attributes}, valid_session
        recipe.reload

        expect(recipe.source_url).to eq new_attributes[:source_url]
      end
    end
  end

  describe "main dish" do
    it "when creating recipe and main dish is checked" do
      post :create, {:recipe => attributes.merge(main_dish: "true")}, valid_session
      recipe = assigns(:recipe)
      expect(MainDishRecipe.where(recipe_id: recipe.id, user_id: user.id).count).to eq 1
    end

    it "when creating recipe and main dish is NOT checked" do
      post :create, {:recipe => attributes.merge(main_dish: "false")}, valid_session
      recipe = assigns(:recipe)
      expect(MainDishRecipe.where(recipe_id: recipe.id, user_id: user.id).count).to eq 0
    end

    context "when recipe exists and main dish exist" do
      before(:each) do
        MainDishRecipe.create(user_id: user.id, recipe_id: recipe.id)
      end

      it "does not add another record when main dish is checked" do
        put :update, {:id => recipe.to_param, :recipe => attributes.merge(main_dish: "true")}, valid_session
        expect(MainDishRecipe.where(recipe_id: recipe.id, user_id: user.id).count).to eq 1
      end

      it "marked meal as deleted record when main dish is not checked" do
        put :update, {:id => recipe.to_param, :recipe => attributes.merge(main_dish: "false")}, valid_session
        filter = {recipe_id: recipe.id, user_id: user.id}
        expect(MainDishRecipe.where(filter).count).to eq 1
        expect(MainDishRecipe.find_by(filter).active).to be false
      end
    end

    context "when recipe does not exists in main dish" do
      it "adds record when main dish is checked" do
        put :update, {:id => recipe.to_param, :recipe => attributes.merge(main_dish: "true")}, valid_session
        expect(MainDishRecipe.where(recipe_id: recipe.id, user_id: user.id).count).to eq 1
      end

      it "does not add record when main dish is not checked" do
        put :update, {:id => recipe.to_param, :recipe => attributes.merge(main_dish: "false")}, valid_session
        expect(MainDishRecipe.where(recipe_id: recipe.id, user_id: user.id).count).to eq 0
      end
    end
  end

  describe "array attributes" do
    describe "ingredients" do
      it "does not save empty ingredients" do
        ingredients = {"0"=>{"name"=>"soy"}, 
                       "1"=>{"name"=>""}, 
                       "2"=>{"name"=>""}, 
                       "3"=>{"name"=>"sugar"},
                       "4"=>{"name"=>""}}

        params = attributes.dup
        params["ingredients_attributes"] = ingredients

        post :create, {:recipe => params}, valid_session

        expect(recipe_values(:ingredients)).to match_array ["soy", "sugar"]
      end

      it "updates ingredients" do
        ingredient1 = Ingredient.create(name: "tomato");
        ingredient2 = Ingredient.create(name: "lettuce");
        recipe.ingredients = [ingredient1, ingredient2]

        ingredients = {"0"=>{"name"=>"soy"}, 
                       "1"=>{"id": ingredient1.id, "name"=>""}, 
                       "2"=>{"name"=>""}, 
                       "3"=>{"id": ingredient2.id, "name"=>"sugar"},
                       "4"=>{"name"=>""}}

        params = attributes.dup
        params["ingredients_attributes"] = ingredients

        put :update, {:id => recipe.to_param, :recipe => params}, valid_session

        expect(recipe_values(:ingredients)).to match_array ["soy", "sugar"]
      end
    end
  end

  def recipe_values(method_name)
    r = assigns(:recipe).reload
    r.send(method_name).map {|i| i.name}
  end

  before(:each) do
    Rails.application.env_config["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end
  let(:user) {UserFactory.create}

  let(:valid_session) { {} }
end
