class MealPlanGenerator

  def self.create(user_id, start_date, end_date)
    plan = Plan.new(user_id: user_id, start_date: start_date, end_date: end_date)
    generator = MealPlanGenerator.new(plan)
    generator.create_plan
    plan
  end

  attr_reader :plan
  POSSIBLE_RECIPES_PER_MEAL = 5;

  def initialize(plan)
    @plan = plan
  end

  def create_plan
    meal_recipe = MealRecipe.find_by_sql ['SELECT  DISTINCT * FROM meal_recipes WHERE user_id = ? ORDER BY last_used ASC NULLS FIRST, created_at DESC LIMIT ?', plan.user_id, plan.size]
    meal_recipe = meal_recipe.shuffle
    meal_recipe = meal_recipe.cycle
    meal_recipe = meal_recipe.take(plan.size)
    plan.meals = meal_recipe.map{|m| Meal.new(m.meal_id)}
  end
end
