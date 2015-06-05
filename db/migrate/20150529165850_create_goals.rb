class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name
      t.date :start_date
      t.date :end_date
      t.string :category
      t.string :operator
      t.boolean :is_expense
      t.float :target_value
      t.integer :budget_id
      t.boolean :achieved, default: false
      t.boolean :reported, default: false

      t.timestamps null: false
    end
  end
end
