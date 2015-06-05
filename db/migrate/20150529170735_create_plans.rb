class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :goal_id
      t.integer :month_id
      t.integer :category_id
      t.integer :m_value
      t.boolean :successful, default: false
      t.boolean :reported, default: false

      t.timestamps null: false
    end
  end
end
