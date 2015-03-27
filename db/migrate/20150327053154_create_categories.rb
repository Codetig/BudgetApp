class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :expense
      t.decimal :projected_value, precision: 10, scale: 2
      t.decimal :week1, precision: 10, scale: 2
      t.decimal :week2, precision: 10, scale: 2
      t.decimal :week3, precision: 10, scale: 2
      t.decimal :week4, precision: 10, scale: 2
      t.text :desc
      t.string :smiley

      t.timestamps null: false
    end
  end
end
