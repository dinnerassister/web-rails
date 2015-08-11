class HomePageController < ApplicationController

  def main
    if current_user
      plan = current_plan
      if plan
        
      else
        redirect_to '/recipes/index'
      end
    else
      redirect_to '/recipes/index'
    end
  end

  def current_plan
    meal = PlanMeal.find_by(meal_date: Date.today)
    if meal
      return Plan.find(meal.plan_id)
    end
  end
end
