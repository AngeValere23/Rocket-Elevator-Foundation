
module RailsAdmin
    module Config
      module Actions
        class Map< RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)
  
          register_instance_option :root do
            true
          end
  
          register_instance_option :http_methods do
            [:get]
          end
  
          register_instance_option :controller do
            proc do
              if request.get? # EDIT
                @weather_client = OpenWeather::Client.new(
                    api_key: ENV["WEATHER_KEY"]
                  )
                respond_to do |format|
                  format.html { render @action.template_name }
                  format.js   { render @action.template_name, layout: false }
                end
              end
            end
          end
  
          register_instance_option :link_icon do
            'icon-map-marker'
          end
        end
      end
    end
  end