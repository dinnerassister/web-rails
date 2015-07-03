require 'recipes/tag_generator'

class Tag < ActiveRecord::Base
  has_and_belongs_to_many :recipes, join_table: "recipes_tags"

  after_commit Recipes::TagGenerator.new
end
