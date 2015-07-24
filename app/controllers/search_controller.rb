class SearchController < ApplicationController

  def tags
    @recipes = Recipe.with_tag(params[:name])
    render 'list'
  end

  def all
    @recipes = Recipe.all
  end

  def user
    @recipes = Recipe.where(user_id: current_user.id).order('created_at DESC')
    @recipes_in_meal_plan = MealRecipe.where(user_id: current_user.id).pluck(:recipe_id).uniq
    render 'list'
  end
end
