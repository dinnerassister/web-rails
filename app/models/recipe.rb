class Recipe < ActiveRecord::Base
  has_many :ingredients, dependent: :delete_all
  accepts_nested_attributes_for :ingredients, :allow_destroy => true

  has_many :photos, :dependent => :delete_all, class_name: 'RecipePhoto'
  accepts_nested_attributes_for :photos, :allow_destroy => true

  has_and_belongs_to_many :tags, join_table: "recipes_tags"
  accepts_nested_attributes_for :tags

  validates :name, :directions, presence: true

  def photo
    p = photos.first || RecipePhoto.new
    p.photo
  end

  def self.with_tag(tag)
    Recipe.find_by_sql ["SELECT recipes.* FROM recipes JOIN recipes_tags ON recipes_tags.recipe_id = recipes.id JOIN tags ON tags.id = recipes_tags.tag_id WHERE tags.name=?", tag]
  end

  def self.with_meal_id(meal_id)
    Recipe.find_by_sql ["SELECT recipes.* FROM recipes JOIN meal_recipes ON meal_recipes.recipe_id = recipes.id WHERE meal_recipes.meal_id = ?", meal_id]
  end

  def self.for(user_id)
    Recipe.where(user_id: user_id).order('created_at DESC')
  end
end
