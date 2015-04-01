class Category < ActiveRecord::Base
  validates :name, presence: true
  validates :proj_val, :period1, :period2, :period3, :period4, numericality: true
  belongs_to :month

  def actuals
    (0..4).reduce {|s, n| eval("s + self.period#{n}")}
  end

  def self.make_defaults month
    bool = [false, true]
    val = ["projected_income", "projected_exp"]
    exp =["income", "expenses"]
    (0..1).each do |i| 
      Category.create(name: exp[i].capitalize, expense: bool[i], desc: "Includes all #{exp[i]}. If you plan to add your own categories, consider removing or renaming this category.", month_id: month[:id], proj_val: month[val[i].to_sym], period1: 0, period2: 0, period3: 0, period4: 0)
    # binding.pry
    end
  end
end
