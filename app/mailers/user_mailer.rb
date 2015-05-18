class UserMailer < ApplicationMailer
  default from: 'notification@mon.com'

  def hello_user(user)
    @user = user
    # @url = 'http://localhost:3000'
    mail(to: @user.email, subject: "Welcome Email") unless @user.email =~ /(.*)(test.com)/
  end

  def update_actuals
    users = User.all
    users.each do |user|
      @user = user
      mail(to: @user.email, subject: "Mon! Budget: Add Actual Amount") unless @user.email =~ /(.*)(test.com)/
    end
  end

end
