class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  after_create :update_detail_fields
  after_update :update_detail_fields, if: :user_input_change? 

  private
  def update_detail_fields
    (3..6).each do |n|
      self[attribute_keys[n]] = parse_user_input[n - 3]
    end
    self.save
  end

  def attribute_keys
    self.attribute_names
  end

  def parse_user_input
    self.name.split
  end

  def user_input_change?
    self.changed == ["name"]
  end
end
