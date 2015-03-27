class CreateMonths < ActiveRecord::Migration
  def change
    create_table :months do |t|
      t.string :name
      t.date :month_date
      t.decimal :projected_income, precision: 10, scale: 2
      t.decimal :projected_exp, precision: 10, scale: 2
      t.decimal :actual_income, precision: 10, scale: 2
      t.decimal :actual_exp, precision: 10, scale: 2

      t.timestamps null: false
    end
  end
end
