class Tag < ActiveRecord::Base
  has_and_belongs_to_many :recipes, join_table: "recipes_tags"
  before_save :down_case

  private
  def down_case
    self.name = self.name.downcase
  end
end
