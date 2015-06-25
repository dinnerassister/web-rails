class Recipe < ActiveRecord::Base
  has_many :ingredients, dependent: :delete_all
  accepts_nested_attributes_for :ingredients, :allow_destroy => true

  has_many :photos, :dependent => :delete_all, class_name: 'RecipePhoto'
  accepts_nested_attributes_for :photos, :allow_destroy => true

  validates :name, :directions, presence: true

  def photo
    p = photos.first || RecipePhoto.new
    p.photo
  end
end
