require 'rubygems'
require 'twilio-ruby'

class SendAlertJob < ApplicationJob
  queue_as :default

  def perform(id, from)
    @alert = Alert.find(id)
    account_sid = ENV.fetch('TWILIO_ACCOUNT_SID', nil)
    auth_token = ENV.fetch('TWILIO_AUTH_TOKEN', nil)
    @client = Twilio::REST::Client.new(account_sid, auth_token)
    case from
    when "task"
      send_message
    when "welcome"
      send_welcome_message
    end
  end

  def send_message
    @client.messages.create(
      body: 'Nous avons trouvé des spots qui correspondent à vos critères',
      from: '+15627848285',
      to: "+33#{@alert.telephone_number[1..]}"
    )
  end

  def send_welcome_message
    body = "Hello, on a bien pris en compte ta demande de notification avec une force de vent comprise entre #{@alert.wind_min}nd et #{@alert.wind_max}nd, pour #{@alert.difficulty.split(",").join(" & ")} vers #{@alert.address}."
    @client.messages.create(
      body:,
      from: '+15627848285',
      to: "+33#{@alert.telephone_number[1..]}"
    )
  end
end
