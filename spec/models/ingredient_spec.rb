require 'rails_helper'
require 'helpers/ingredient_factory'
require 'helpers/recipe_factory'

describe Ingredient do
  context "raise error" do
    it "when create new ingredient with wrong recipe id" do
      expect{ Recipe.find(1) }.to raise_error

      expect { IngredientFactory.create(name: "banana 1 ea", recipe_id: 1) }.to raise_error
    end
  end

  context "update detail fields with name parsers" do
    before(:each) do
      recipe = RecipeFactory.create
      @ingredient = IngredientFactory.create(name: "Sugar 1 cup", recipe_id: recipe.id)
    end

    it "when create new ingredient" do
      name_parsers = @ingredient.name.split

      expect(name_parsers).to eq ["Sugar", "1", "cup"]

      expect(@ingredient.item).to eq name_parsers[0]
      expect(@ingredient.quantity).to eq name_parsers[1].to_f
      expect(@ingredient.unit).to eq name_parsers[2]
      expect(@ingredient.description).to eq nil
    end

    it "when update ingredient name" do
      expect(@ingredient.attributes.values[1..6]).to eq ["Sugar 1 cup", @ingredient.recipe_id, "Sugar", 1, "cup", nil]

      @ingredient.update(name: "Salt 2 tbs Organic")

      name_parsers = @ingredient.name.split

      expect(name_parsers).to eq ["Salt", "2", "tbs", "Organic"]

      expect(@ingredient.item).to eq name_parsers[0]
      expect(@ingredient.quantity).to eq name_parsers[1].to_f
      expect(@ingredient.unit).to eq name_parsers[2]
      expect(@ingredient.description).to eq name_parsers[3]
    end
  end
end
