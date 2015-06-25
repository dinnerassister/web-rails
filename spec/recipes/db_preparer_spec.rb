require 'rails_helper'
require 'helpers/file_helper'
require 'recipes/db_preparer'

RSpec.describe Recipes::DbPreparer do
  let(:service) { Recipes::DbPreparer }
  let(:user_id) { 1131 }
  let(:params) {{ingredients_attributes: []}}

  it "sets the user id" do
    new_params = service.process(user_id, params)
    expect(new_params[:user_id]).to eq(user_id)
  end

  it "remove empty ingredients without id" do
    ingredients = {"0"=>{name: "soy"}, 
                   "1"=>{name: ""}, 
                   "3"=>{name: "sugar"},
                   "4"=>{name: "", id: 2},
                   "5"=>{name: ""}}

    params[:ingredients_attributes] = ingredients
    new_params = service.process(user_id, params)

    new_ingredients = new_params[:ingredients_attributes].map {|index, v| index}

    expect(new_ingredients).to match_array ["0", "3", "4"]
  end

  it "sets empty ingredients with id to delete" do
    delete_ingredient = {name: "", id: 3}
    ingredients = {"0"=>{name: "soy"}, 
                   "1"=> delete_ingredient}

    params[:ingredients_attributes] = ingredients
    new_params = service.process(user_id, params)

    expect(delete_ingredient[:_destroy]).to be true
  end

  it "sets user id in photo" do
    params[:photos_attributes] = {"0" => {id: 2, photo: "filename.jpg"}, 
                                  "1" => {id: 1, photo: "yummy.jpg"}}

    new_params = service.process(user_id, params)

    params[:photos_attributes].each do |key, value|
      expect(value[:user_id]).to be user_id
    end
  end

end

