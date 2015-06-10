class RecipePhoto < ActiveRecord::Base
  belongs_to :recipe
  has_attached_file :photo, :styles => { small: "250x250>", :medium => "500x500>" }, :default_url => "/images/default_plate.png"
  validates_attachment :photo, :content_type => { :content_type => /\Aimage\/.*\Z/},
                               :size => { :in => 0..10.megabytes }
end