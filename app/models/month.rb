class Month < ActiveRecord::Base
  validates :projected_income, :projected_exp, :actual_income, :actual_exp, numericality: true
  validates :month_date, presence:true

  belongs_to :budget
  has_many :categories

  #method to set name to the name of the month if name is not provided

  def calc_actuals
    self.actual_exp = 0
    self.actual_income = 0
    categories = self.categories
    categories.each do |cat|
      self.actual_exp += cat.actuals if cat.expense
      self.actual_income += cat.actuals unless cat.expense
    end
  end

  def calc_projected
    self.projected_exp = 0
    self.projected_income = 0
    categories = self.categories
    categories.each do |cat|
      self.projected_exp += cat.proj_val if cat.expense
      self.projected_income += cat.proj_val unless cat.expense
    end
  end

  def current_month?
    today = Date.today
    given_date = self.month_date
    today.year == given_date.year && today.month == given_date.month
  end

  def month_exists?
    return false unless self.month_date
    mon_yr = [self.month_date.year, self.month_date.month]
    months = Month.where(budget_id: self.budget_id)
    months.any? { |month| month.month_date.year == mon_yr[0] && month.month_date.month == mon_yr[1]  }
  end

  def self.make_current_month budget_id
    create(
      name: Date.today.strftime("%B"),
      month_date: Date.today,
      projected_income: 0,
      projected_exp: 0,
      actual_income: 0,
      actual_exp: 0,
      budget_id: budget_id
      )
  end
end
