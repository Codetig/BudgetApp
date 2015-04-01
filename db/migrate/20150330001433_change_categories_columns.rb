class ChangeCategoriesColumns < ActiveRecord::Migration
  def change
    rename_column :categories, :week2, :period2
    rename_column :categories, :week3, :period3
    rename_column :categories, :week4, :period4
    rename_column :categories, :projected_value, :proj_val
    change_column_default :categories, :period1, 0
    change_column_default :categories, :period2, 0
    change_column_default :categories, :period3, 0
    change_column_default :categories, :period4, 0
    change_column_default :categories, :proj_val, 0
    change_column_null :categories, :period1, false
    change_column_null :categories, :period2, false
    change_column_null :categories, :period3, false
    change_column_null :categories, :period4, false
    change_column_null :categories, :proj_val, false
  end
end
