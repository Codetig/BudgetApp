class ChangeCategories < ActiveRecord::Migration
  def change
    add_column :categories, :month_id, :integer
    rename_column :categories, :week1, :period1
  end
end
