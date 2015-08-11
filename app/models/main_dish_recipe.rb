class MainDishRecipe < ActiveRecord::Base
  def self.add_recipe(user_id, recipe_id)
    add_recipes(user_id, [recipe_id])
  end

  def self.add_recipes(user_id, recipe_ids)
    MainDishRecipe.transaction do
      recipe_ids.each do |id|
        meal = MainDishRecipe.find_or_create_by(user_id: user_id, recipe_id: id)
        meal.update(active: true)
        meal_recipe = MealRecipe.find_or_create_by(user_id: user_id, recipe_id: id)
        meal_recipe.update(active: true)
      end
    end
  end

  def self.delete_recipe(user_id, recipe_id)
    delete_recipes(user_id, [recipe_id])
  end

  def self.delete_recipes(user_id, recipe_ids)
    MainDishRecipe.where("user_id = ? AND recipe_id IN (?)", user_id, recipe_ids).update_all(active: false)
  end

  def self.recipe_ids_for(user_id)
    MainDishRecipe.where(user_id: user_id).pluck(:recipe_id).uniq
  end

  def self.update_meal(meal_id, attritubes)
    MainDishRecipe.where(meal_id: meal_id).update_all(attritubes)
  end
end
