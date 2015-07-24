class MealRecipe < ActiveRecord::Base

  def self.add_recipes(user_id, recipe_ids)
    MealRecipe.transaction do
      recipe_ids.each do |id|
        meal = MealRecipe.find_or_create_by(user_id: user_id, recipe_id: id)
        meal.update(active: true)
      end
    end
  end

  def self.delete_recipes(user_id, recipe_ids)
    MealRecipe.where("user_id = ? AND recipe_id IN (?)", user_id, recipe_ids).update_all(active: false)
  end
end
