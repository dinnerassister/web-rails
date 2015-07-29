class IngredientsController < ApplicationController
  before_action :authenticate_user!

  def index
    @ingredients = Ingredient.all
  end

  def edit
  end

  def update
    if @ingredient.update_attributes(ingredient_params)
      redirect_to "index", notice: "Ingredients were successfully updated."
    else
      render "edit"
    end     
  end

  private
  def get_product
    @ingredient = Ingredient.find(params[:id])    
  end
  def ingredient_params
    params.require(:ingredient).permit(:item, :quantity, :unit, :description)
  end
end
