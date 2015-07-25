class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.date :start_date
      t.date :end_date
      t.integer :user_id, index: true, null: false

      t.timestamps null: false
    end
  end
end
