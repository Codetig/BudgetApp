class Plan < ActiveRecord::Base

  belongs_to :goal
  belongs_to :month
  belongs_to :category

  def self.make_generic month, goal, val, category
    Plan.create(
      month_id: month.id,
      goal_id: goal.id,
      category_id: category.id,
      m_value: val
      )
    # Category.make_defaults(month)
  end
end
