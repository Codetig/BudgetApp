# require 'clockwork'
# require './config/boot'
# require './config/environment'

# module Clockwork
#   handler do |job|
#     if job.eq?'send_update_actuals'
#       UserMailer.update_actuals.deliver
#     end
#     puts "Running #{job}"
#   end


# every(1.day, 'send_update_actuals', :if => lambda{ |t| t.day > 6 && t.day.saturday? })

# end