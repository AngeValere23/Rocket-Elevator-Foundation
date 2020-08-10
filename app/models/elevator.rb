require 'uri'
require 'net/http'
require 'openssl'
require 'rubygems'
require 'twilio-ruby'
require 'slack-notifier'
require 'dotenv'


class Elevator < ApplicationRecord
  belongs_to :column
  before_save :send_txt
  before_update :slack_notifier

  def userid
    return self.Column.battery.building.customer.user.id
  end

  def send_txt
    if self.Status_changed?
      
      if self.Status == "Intervention"
		
		phone_to = self.column.battery.building.BuildingTechPhone
    
    sms = "Mr/Mrs #{self.column.battery.building.BuildingTechFullName} The Elevator ID: #{self.id} located at #{self.column.battery.building.address.NumberAndStreet}, #{self.column.battery.building.address.City} with Serial Number #{self.serialNumber} changed status to #{self.Status}"
		account_sid = ENV['TWILIO_ACCOUNT_SID']
		auth_token = ENV['TWILIO_AUTH_TOKEN']
		@client = Twilio::REST::Client.new(account_sid, auth_token)

		message = @client.messages.create(
									body: sms,
									from: '+15812058687',
									to: phone_to
								)
    

      end
    end
    
  end
  
  def slack_notifier
    if self.Status_changed?
      require 'date'
      current_time = DateTime.now.strftime("%d-%m-%Y %H:%M")
      notifier = Slack::Notifier.new ENV["SLACK_API_WEBHOOK_URL"]  do
        defaults channel: "#elevators_operations"
      end
      notifier.ping "The Elevator #{self.id} with Serial Number #{self.serialNumber} changed status from #{self.Status_was} to #{self.Status} at #{current_time}."
    end
  end
end
