class Meal
  attr_accessor :id, :date
  attr_writer :recipes

  def initialize(meal_id, date = Date.today)
    @id = meal_id
    @date = date
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
