class Recipe < ActiveRecord::Base
  has_many :ingredients, dependent: :delete_all
  accepts_nested_attributes_for :ingredients
  validates :name, :directions, presence: true
end
