class Goal < ActiveRecord::Base
  validates :end_date, :operator, :category, :target_value, :budget_id, presence: true

  belongs_to :budget
  has_many :plans, dependent: :destroy
  has_many :months, through: :plans
  has_many :categories, through: :plans

  def extend_time date
    e0 = self.start_date
    e1 = date
    e2 = self.end_date
    n_months = e2.year == e0.year ? e2.month - e0.month + 1 : (12 - e0.month) + e2.month + 1

    m_val = self.target_value / n_months
    e1 = e1.advance(months: +1)

    until e1 > e2
      c = self.make_category(e1, m_val)
      Plan.make_generic c.month, self, m_val, c
      e1 = e1.advance(months: +1)
    end
  end

  def dec_time
    e = self.end_date.advance(months: +1)
    cats = self.categories
    
      cats.each do |cat|
        plan = cat.plan

        if cat.month.month_date >= e
          plan.destroy
          cat.destroy 
        end
      end
  end

  def expense_goal?
    self.categories[0].expense
  end

  def total_actual_value
    self.categories.reduce(0) {|sum, cat| sum += cat.actuals}
  end

  def make_category date, m_val
    month = Month.new(
        name: date.strftime("%B"),
        month_date: date,
        projected_income: 0,
        projected_exp: 0,
        actual_income: 0,
        actual_exp: 0,
        budget_id: self.budget_id
        )
      if month.month_exists?
        month = Month.where(month_date: month.month_date)[0]
      else
        month.save
        Category.make_defaults(month)
      end
      
      c = Category.create(name: "Goal - " + self.category, 
        expense: self.is_expense, 
        desc: "Goal (#{self.name}) generated category", 
        month_id: month.id, 
        proj_val: m_val, 
        period1: 0, period2: 0, period3: 0, period4: 0)
      month.categories << c
      month.save
      c
  end

  def make_plans
    s = self.start_date
    e = self.end_date
    n_months = e.year == s.year ? e.month - s.month + 1 : (12 - s.month) + e.month + 1 #'+1' because the starting month is included

    m_val = self.target_value / n_months
    
    until s > e
      c = self.make_category(s, m_val)
      Plan.make_generic c.month, self, m_val, c
      s = s.advance(months: +1)
    end
  end
end
