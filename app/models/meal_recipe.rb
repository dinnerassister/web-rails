class MealRecipe < ActiveRecord::Base
  before_create :add_meal_id

  def self.add_recipe(user_id, recipe_id)
    add_recipes(user_id, [recipe_id])
  end

  def self.add_recipes(user_id, recipe_ids)
    MealRecipe.transaction do
      recipe_ids.each do |id|
        meal = MealRecipe.find_or_create_by(user_id: user_id, recipe_id: id)
        meal.update(active: true)
      end
    end
  end

  def self.delete_recipe(user_id, recipe_id)
    delete_recipes(user_id, [recipe_id])
  end

  def self.delete_recipes(user_id, recipe_ids)
    MealRecipe.where("user_id = ? AND recipe_id IN (?)", user_id, recipe_ids).update_all(active: false)
  end

  def self.recipe_ids_for(user_id)
    MealRecipe.where(user_id: user_id).pluck(:recipe_id).uniq
  end

  def self.update_meal(meal_id, attritubes)
    MealRecipe.where(meal_id: meal_id).update_all(attritubes)
  end

  private
  def add_meal_id
    self.meal_id = SecureRandom.uuid unless self.meal_id
  end
end
