require 'rails_helper'
require 'helpers/file_helper'

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
end
