class Meal
  attr_accessor :id
  attr_writer :recipes

  def initialize(meal_id)
    @id = meal_id
  end

  def recipes
    []
  end


end
