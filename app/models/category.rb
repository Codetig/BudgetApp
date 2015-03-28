class Category < ActiveRecord::Base
  validates :name, :expense, presence: true
  validates :projected_value, :week1, :week2, :week3, :week4, numericality: true
end
