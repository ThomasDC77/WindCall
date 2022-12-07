require 'rubygems'
require 'twilio-ruby'

class SendAlertJob < ApplicationJob
  queue_as :default

  def perform(id)
    @alert = Alert.find(id)
    account_sid = ENV['TWILIO_ACCOUNT_SID']
    auth_token = ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    send_message
  end

  def send_message
    message = @client.messages.create(
      body: 'Nous avons trouvé des spots qui correspondent à vos critères',
      from: '+15627848285',
      to: @alert.telephone_number
    )
  end
end
