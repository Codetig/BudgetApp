class AddBudgetIdToMonths < ActiveRecord::Migration
  def change
    add_column :months, :budget_id, :integer
  end
end
