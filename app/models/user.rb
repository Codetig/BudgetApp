class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # has_secure_password
  validates :email, :first_name, :last_name, :birthday, :cell_num, presence: true
  validates :cell_num, length: {is: 10}
  validates :email, uniqueness: {case_sensitive: false}
  has_one :budget, dependent: :destroy

  def fullname
    "#{self.first_name} #{self.last_name}"
  end

  def gen_budget
    return nil if self.budget
    Budget.create(name:"#{self.first_name}'s Budget", desc:"Your very own budget", user_id: self.id)
    # UserMailer.hello_user(self).deliver_now
  end
end
