module SearchHelper
  def shorten(value)
    trailing = ""
    trailing = "..." if value.length > 40
    value[0, 40] + trailing
  end

  def selected?(recipe_id)
    if @recipes_in_meal_plan.include?(recipe_id)
      "selected"
    end
  end
end
