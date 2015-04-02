class UserMailer < ApplicationMailer
  default from: 'notification@monmon.com'

  def hello_user (user)
    @user = user
    @url = 'http://localhost:3000'
    mail(to: @user.email, subject: "Sample Email")
  end
end
