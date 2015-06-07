desc "This task is called by the Heroku scheduler add-on"
task :actuals_reminder => :environment do
  puts "Sending reminder to update actuals..."
  User.find_each do |user|
    UserMailer.update_actuals(user).deliver_now if (Time.now.sunday? && Time.now.day > 6)
  end
  puts "emails sent; done."
end

# task :send_reminders => :environment do
#   User.send_reminders
# end