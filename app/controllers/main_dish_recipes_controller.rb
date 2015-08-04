class MainDishRecipesController < ApplicationController
  before_action :authenticate_user!

  def add
    MainDishRecipe.add_recipes(current_user.id, recipe_ids_params)
    render plain: "Saved!"
  end

  def delete
    MainDishRecipe.delete_recipes(current_user.id, recipe_ids_params)
    render plain: "Deleted!"
  end

  def add_recipe
    recipe_id = recipe_id_params
    if integer?(recipe_id) && Recipe.exists?(recipe_id)
      MainDishRecipe.add_recipe(current_user.id, recipe_id)
      render plain: "Saved!"
    else
      render plain: "Recipe id doesn't exist."
    end
  end

  def delete_recipe
    MainDishRecipe.delete_recipes(current_user.id, [recipe_id_params])
    render plain: "Deleted!"
  end

  private
  def recipe_id_params
    params.require(:recipe_id)
  end

  def recipe_ids_params
    params.require(:recipe_ids)
  end

  def integer?(value)
     /\A[-+]?\d+\z/ === value
  end

end
