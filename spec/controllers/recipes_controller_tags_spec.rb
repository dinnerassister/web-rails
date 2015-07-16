require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  include Devise::TestHelpers

    let(:params) {{ "name"=>"tofu", "directions"=>"cook"}}

    let (:recipe) {Recipe.create(name: "old name", directions: "old directons")}

  it "saves existing tag" do
    tag = Tag.create(name: "vietnamese")
    post :create, {:recipe => params, :tags => [tag.name]}, valid_session

    expect(recipe_values(:tags)).to match_array [tag.name]
    expect(Tag.where(name: tag.name).count).to eq(1)
  end

  it "updates tags" do
    tag1 = Tag.create(name: "same name");
    tag2 = Tag.create(name: "appetizer");
    recipe.tags = [tag1, tag2]

    put :update, {:id => recipe.to_param, :recipe => params, tags: [tag2.name, "new tag"]}, valid_session

    expect(recipe_values(:tags)).to match_array [tag2.name, "new tag"]
  end

  it "downcases tag" do
    post :create, {:recipe => params, :tags => ["PotAto"]}, valid_session
    expect(recipe_values(:tags)).to match_array ["potato"]
  end

  it "strips html tags" do
    post :create, {:recipe => params, :tags => ["<script>bad</script>Bread"]}, valid_session
    expect(recipe_values(:tags)).to match_array ["bread"]
  end

  it "does not save empty tag" do
    post :create, {:recipe => params, :tags => [""]}, valid_session
    expect(recipe_values(:tags)).to eq []
  end

  it "does not save tag inside html tag" do
    post :create, {:recipe => params, :tags => ["<script>alert('hi')<script>"]}, valid_session
    expect(recipe_values(:tags)).to eq []
  end 

  it "removes tags" do
    tag1 = Tag.create(name: "same name");
    tag2 = Tag.create(name: "appetizer");
    recipe.tags = [tag1, tag2]

    put :update, {:id => recipe.to_param, :recipe => params, tags: []}, valid_session

    expect(recipe_values(:tags)).to match_array []
  end

  it "removes all tags when there is no tag submitted" do
    tag1 = Tag.create(name: "same name");
    tag2 = Tag.create(name: "appetizer");
    recipe.tags = [tag1, tag2]

    put :update, {:id => recipe.to_param, :recipe => params}, valid_session

    expect(recipe_values(:tags)).to match_array []
  end

  it "ignores capitalization duplicates" do
    post :create, {:recipe => params, :tags => ["vegi", "Vegi"]}, valid_session

    expect(recipe_values(:tags)).to match_array ["vegi"]
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
