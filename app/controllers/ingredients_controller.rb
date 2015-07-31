class IngredientsController < ApplicationController
  before_action :get_ingredient, only: [:update]
  before_action :authenticate_user!

  def index
    @ingredients = Ingredient.all.sort
  end

  def update
    if @ingredient.update(name: params[:name])
      flash[:notice] = "Ingredients were successfully updated.";
      render :js => "window.location = '/ingredients'"
    else
      render "index", notice: "error"
    end     
  end

  private
  def get_ingredient
    @ingredient = Ingredient.find(params[:id])
  end
end
