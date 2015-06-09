class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :directions
      t.integer :prep_time
      t.integer :cook_time
      t.boolean :reviewed
      t.string :source_url
      t.integer :serving
      t.integer :user_id, index: true

      t.timestamps null: false
    end
  end
end
