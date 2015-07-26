class Meal
  attr_accessor :id
  attr_writer :recipes

  def initialize(meal_id = SecureRandom.uuid)
    @id = meal_id
  end

  def recipes
    @recipes ||= Recipe.with_meal_id(id)
  end

  def photo
    recipes.first.photo
  end

  def update(attritubes)
    MealRecipe.update_meal(id, attritubes)
  end
end
