require 'rails_helper'
require 'helpers/recipe_factory'

RSpec.describe Recipe do
  context "gets photo" do
    let(:recipe) {Recipe.new}

    it "when there is no photo" do
      expect(recipe.photo.url).to eq RecipePhoto.new.photo.url
    end

    it "when there is more than one photo" do
      photo1 = RecipePhoto.new(photo: FileHelper.image("flower.jpg"))
      photo2 = RecipePhoto.new

      recipe.photos = [photo1, photo2]

      expect(recipe.photo.url).to eq photo1.photo.url
    end
  end

  context "find recipe with tag" do
    let(:tag) {Tag.create(name: "Pineapple")}

    it "returns the recipe with the given tag" do
      recipe = RecipeFactory.create(tags: [tag])
      expect(Recipe.with_tag(tag.name)).to include(recipe)
    end

    it "does not return recipe without the tag" do
      recipe = RecipeFactory.create
      expect(Recipe.with_tag(tag.name)).to_not include(recipe)
    end
  end
end
