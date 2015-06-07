class UserMailer < ApplicationMailer
  default from: 'notification@mon.com'

  def hello_user(user)
    @user = user
    # @url = 'http://localhost:3000'
    mail(to: @user.email, subject: "Welcome Email") unless /(.*)(test.com)/ =~ @user.email
  end

  def update_actuals(user)
      @user = user
      mail(to: @user.email, subject: "Mon! Budget: Add Actual Amount") unless /(.*)(@test.com)/ =~ @user.email
  end

end
