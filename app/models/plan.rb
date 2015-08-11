class Plan < ActiveRecord::Base
  attr_writer :meals

  def meals
    @meals ||= load_meals
  end

  def size
    @size ||= (end_date - start_date).to_i.abs + 1
  end

  def today_meal
    
  end

  private
  def load_meals
    PlanMeal.find_by(plan_id: self.id).each do |m|
      Meal.new(m.meal_id)
    end
  end
end
