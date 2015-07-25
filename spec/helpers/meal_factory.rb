class MealFactory
  def self.create_meals_for(user_id, meal_size)
    (0...meal_size).map {|x| create(1, user_id)}
  end

  def self.create(recipe_size, user_id = SecureRandom.uuid)
    meal = Meal.new(SecureRandom.uuid)
    meal.recipes = create_recipes_for(meal.id, recipe_size, user_id)
    meal
  end

  def self.create_recipes_for(meal_id, size, user_id = SecureRandom.uuid)
    (0...size).map do |x|
      recipe = RecipeFactory.create(name: x.to_s)
      MealRecipe.create(user_id: 13, recipe_id: recipe.id, meal_id: meal_id)
      recipe
    end
  end
end
