class RecipePhoto < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :user
  has_attached_file :photo, :styles => { small: "150x150>", :medium => "500x500>" }, 
                            :default_url => "/images/default_plate.png"

  validates_attachment :photo, :content_type => { :content_type => /\Aimage\/.*\Z/},
                               :size => { :in => 0..10.megabytes }

  attr_accessor :_destroy

end
