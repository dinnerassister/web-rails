class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :name
      t.belongs_to :recipe, index: true, foreign_key: true
    end
  end
end
