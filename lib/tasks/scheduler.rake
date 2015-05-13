desc "This task is called by the Heroku scheduler add-on"
task :actuals_reminder => :environment do
  puts "Sending reminder to update actuals..."
  UserMailer.update_actuals.deliver_now if (Time.now.saturday? && Time.now.day > 6)
  puts "emails sent done."
end

# task :send_reminders => :environment do
#   User.send_reminders
# end