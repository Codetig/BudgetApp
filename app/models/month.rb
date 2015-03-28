class Month < ActiveRecord::Base
  validates :projected_income, :projected_exp, :actual_income, :actual_exp, numericality: true
  validates :month_date, presence:true

  belongs_to :budget
  has_many :categories

  #method to set name to the name of the month if name is not provided
end
