class CreateRecipePhotos < ActiveRecord::Migration
  def change
    create_table :recipe_photos do |t|
      t.integer :recipe_id, index: true
      t.integer :user_id, index: true
      t.string :description
      t.attachment :photo
    end
  end
end
