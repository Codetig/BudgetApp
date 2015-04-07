class UserMailer < ApplicationMailer
  default from: 'notification@mon.com'

  def hello_user(user)
    @user = user
    # @url = 'http://localhost:3000'
    mail(to: @user.email, subject: "Sample Email")
  end
end
