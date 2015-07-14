class Budget < ActiveRecord::Base
  validates :name, :user_id, presence: true

  belongs_to :user
  has_many :months, dependent: :destroy
  has_many :goals, dependent: :destroy

#returns the goal with the earliest end date of today or greater
  def earliest_goal
    self.goals.reduce {|res, goal| res = goal if goal.end_date < res.end_date && goal.end_date > Date.today}
  end

#returns the aggreagate goals' progress as a double for goals with end date of today or greater
  def goals_progress(type)
    exp = type == "expense" ? true : false
    sum_actual = 0
    sum_target = 0
    self.goals.each do |goal|
      if goal.is_expense? == exp && goal.end_date >= Date.today
        sum_target += goal.target_value
        sum_actual += goal.total_actual_value
      end
    end
    (sum_actual/sum_target)
  end

#returns an array of goals ending today
  def goals_ending
    goals = self.goals
    goals.collect {|goal| goal if goal.end_date == Date.today}
  end
  
end
