class SearchController < ApplicationController
  before_action :authenticate_user!, :user

  def tags
    @recipes = Recipe.with_tag(params[:name])
    render 'list'
  end

  def all
    @recipes = Recipe.all
  end

  def user
    @recipes = Recipe.for(current_user.id)
    @recipes_in_meal_plan = MainDishRecipe.recipe_ids_for(current_user.id)
    render 'list'
  end
end
