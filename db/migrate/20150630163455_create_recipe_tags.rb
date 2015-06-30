class CreateRecipeTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, unique: true, index: true, null: false, default: ""

      t.timestamps null: false
    end

    create_table :recipes_tags do |t|
      t.belongs_to :recipe, index: true
      t.belongs_to :tag, index: true
      t.timestamps null: false
    end
  end
end
