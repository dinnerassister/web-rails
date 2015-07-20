class RecipeFactory
  def self.create(fields = {})
    Recipe.create(recipe_fields.merge(fields))
  end

  def self.recipe_fields
    { name: "Apple Pie",
      directions: "1. Go to store.\n2. Find pie section"
    }
  end
end