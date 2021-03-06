require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  include Devise::TestHelpers

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
      let (:recipe) {Recipe.create(name: "old name", directions: "old directons")}
      
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

  describe "array attributes" do
    let (:recipe) {Recipe.create(name: "old name", directions: "old directons")}

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
    sign_in UserFactory.create
  end

  let(:valid_session) { {} }
end
