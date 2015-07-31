class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  after_create :update_detail_field

  private
  def update_detail_field
    self.update(detail_field)
  end

  def detail_field
    { item: parse_user_input[0],
      quantity: parse_user_input[1],
      unit: parse_user_input[2],
      description: parse_user_input[3]
    }
  end

  def parse_user_input
    self.name.split
  end
end
