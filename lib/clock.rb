require 'clockwork'
require './config/boot'
require './config/environment'

module Clockwork

every(1.day, 'send_update_actuals') do
  # puts "Clockwork working!!!"
  Rails.logger.info "Sending update_actuals email" if Rails.env.development?
  UserMailer.update_actuals.deliver_now if (Time.now.saturday? && Time.now.day > 6)
end

end