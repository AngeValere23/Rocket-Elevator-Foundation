=begin
module RailsAdmin
    module Config
      module Actions
        class Dashboard < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)
  
          register_instance_option :root? do
            true
          end
  
          register_instance_option :breadcrumb_parent do
            nil
          end
  
          register_instance_option :auditing_versions_limit do
            100
          end
  
          register_instance_option :controller do
            proc do
              @history = @auditing_adapter && @auditing_adapter.latest(@action.auditing_versions_limit) || []
              if @action.statistics?
                @abstract_models = RailsAdmin::Config.visible_models(controller: self).collect(&:abstract_model)
  
                @most_recent_created = {}
                @count = {}
                @max = 0
                @abstract_models.each do |t|
                  scope = @authorization_adapter && @authorization_adapter.query(:index, t)
                  current_count = t.count({}, scope)
                  @max = current_count > @max ? current_count : @max
                  @count[t.model.name] = current_count
                  next unless t.properties.detect { |c| c.name == :created_at }
                  @most_recent_created[t.model.name] = t.model.last.try(:created_at)
                end
              end
              employee = Employee.find_by(user_id: current_user.id)
                
                if Employee.exists?(user_id: current_user.id) 
                    authenticator = IBMWatson::Authenticators::IamAuthenticator.new(
                apikey: ENV["WATSON_KEY"],
              )
              text_to_speech = IBMWatson::TextToSpeechV1.new(
                authenticator: authenticator
              )
              text_to_speech.service_url = ENV["WATSON_URL"]
              File.open(Rails.root.join('app', 'assets', 'audios', 'welcome.mp3'), "wb") do |audio_file|
                response = text_to_speech.synthesize(
                  text: "Greeting #{employee.firstname} #{employee.lastname} ! There are currently #{Elevator.count} elevators deployed in the #{Building.count} buildings of your #{Customer.count} customers. Currently, #{Elevator.where.not(Status: 'Active').count} elevators are not in Running Status and are being serviced. You currently have #{Quote.count} quotes awaiting processing. You currently have #{Lead.count} leads in your contact requests. #{Battery.count} Batteries are deployed across #{Address.pluck(:city).uniq.count} cities.",
                  accept: "audio/mpeg",
                  voice: "en-US_AllisonVoice"
                ).result
                audio_file.write(response)
            end
                end
              render @action.template_name, status: @status_code || :ok
            end
          end
  
          register_instance_option :route_fragment do
            ''
          end
  
          register_instance_option :link_icon do
            'icon-home'
          end
  
          register_instance_option :statistics? do
            true
          end
        end
      end
    end
  end
=end