require 'spec_helper'
require 'recipes/db_preparer'

RSpec.describe DbPreparer do
  let(:params) {{"name"=> "Tofu Burger", "ingredients_attributes"=> {}}}
  let(:service) {DbPreparer}
  let(:user_id) {1444}

  it "sets the user id" do
    service.prep(params, user_id)
    expect(params["user_id"]).to eq user_id
  end

  it "removes empty ingredients" do
    ingredients = {"0"=>{"name"=>"soy"}, 
                   "1"=>{"name"=>""}, 
                   "2"=>{"name"=>""}, 
                   "3"=>{"name"=>"sugar"},
                   "4"=>{"name"=>""}}

    params["ingredients_attributes"] = ingredients
    service.prep(params, user_id)

    clean_ingredients = {"0"=>{"name"=>"soy"}, 
                         "3"=>{"name"=>"sugar"}}

    expect(params["ingredients_attributes"]).to eq clean_ingredients
  end
end