class PagesController < ApplicationController
  def index
  end
  
  def quote
  end
  
  def corporate
  end
  
  def residential
  end

  def intervention
    if !is_employee? then
      return redirect_to root_path
    end
  end

  def intervention_get_data
    id = request.query_parameters["id"]
    value = request.query_parameters["value"]

    @data = ""
    case value
    when "building"
      @data = Building.where(customer: id)
    when "battery"
      @data = Battery.where(building: id)
    when "column"
      @data = Column.where(battery: id)
    when "elevator"
      @data = Elevator.where(column: id)
    else
      @data = ""
    end
    
    return render json: @data
  end

  def post_intervention
    # Only employee can post
    if !is_employee? then
      return redirect_to root_path
    end
    # Verify recaptcha
    if !verify_recaptcha()
      return redirect_to root_path, notice: "Recaptcha failed !"
    end

    intervention_params = params.except(:authenticity_token, :controller, :action, :utf8, :commit, "g-recaptcha-response")
    intervention_params.permit!

	
    # Save intervention
    @intervention = Intervention.create(AuthorID: Employee.where(:user_id => current_user.id).first,:CustomerID_id => to_number(params[:customer]), :BuildingID_id => to_number(params[:building]), :BatteryID_id => to_number(params[:battery]), :ColumnID_id => to_number(params[:column]), :ElevatorID_id => to_number(params[:elevator]), :EmployeeID_id => params[:employee], :Report => params[:description]) 
    @intervention.save!

    ZendeskAPI::Ticket.create!($client, 
        :type => "Problem", 
          :subject => "Intervention needed", 
            :comment => { 
              :value => "#{Employee.where(id: @intervention.AuthorID).first.firstname} 
                #{Employee.where(id: @intervention.AuthorID).first.lastname} create intervention for 
                #{@intervention.CustomerID.CompanyName} in the building #{@intervention.BuildingID} on battery 
                #{intervention_params[:battery]}, the elevator #{intervention_params[:elevator]} on column #{intervention_params[:column]} need to be fixed by 
                #{@intervention.EmployeeID.firstName} #{@intervention.EmployeeID.lastName}. The description is: #{@intervention.Report} " 
              },
                :priority => "urgent",
                :type => "task"
              )


    # Redirect to confirm
    flash[:notice] = "Your message has been sent "
    redirect_to root_path
  end
  
  def to_number(string)
    Integer(string || '')
  rescue ArgumentError
    nil
  end
  
  def post_quote
    # Verify recaptcha
    if !verify_recaptcha()
      return redirect_to :root_path, notice: "Recaptcha failed !"
    end

    # Get data from the form and omit unecessary data
    quote_params = params.except(:authenticity_token, :controller, :action, :utf8, :commit, "g-recaptcha-response")
    quote_params.permit!

    #Save quote
    @quote = Quote.create(quote_params)
    @quote.save!


    # Zendesk
    ZendeskAPI::Ticket.create!($client,
      :subject =>  "#{quote_params[:fullname]} from #{quote_params[:businessname]}",
       :comment => { 
         :value => "
         The contact #{quote_params[:fullname]} from company #{quote_params[:businessname]} can be reached at email #{quote_params[:email]} and at phone number #{quote_params[:phone]}. 
          Building type : #{quote_params[:buildingtype]}
          Quality : #{quote_params[:quality]}
          Number of elevator : #{quote_params[:nbelevator]}
          Total : #{quote_params[:total]}$

          Quote ID : ##{@quote.id}
         "
       },
       :requester => { 
         "name": quote_params[:fullname], 
         "email": quote_params[:email]
     },
         :priority => "normal",
         :type => "task"
       )
    # Redirect to confirm
    redirect_to root_path
  end

  def post_lead    
    # Verify recaptcha
    if !verify_recaptcha()
      return redirect_to root_path, notice: "Recaptcha failed !"
    end

    # Get data from the form and omit unecessary data
    lead_params = params.except(:authenticity_token, :controller, :action, :utf8, :button, "g-recaptcha-response")
    lead_params.permit!
    file = lead_params[:AttachedFile]

    
    response = HTTParty.post('https://api.deepai.org/api/nsfw-detector', {
      headers: {"api-key": ENV['DEEPAI_KEY']},
      body: {
          "image": file
      }
    })
    score = response["output"]["nsfw_score"].to_f
    if score > 0.2
    # Sendgrid
    from = SendGrid::Email.new(email: ENV['SENGRID_FROM'])
    to = SendGrid::Email.new(email: lead_params[:Email])
    subject = 'Warning from Rocket Elevators'
    content = SendGrid::Content.new(type: 'text/html', value: '
    <html>
      <body>
          <p><img width="500px" src="' +"https://rocket-elevators.frederic2ec.tk" +ActionController::Base.helpers.image_url("rocket_elevators/logo.png") + '" /></p>
          
          <p><a>Greetings '+ lead_params[:FullName] +'</a></p>
          <p>We thank you for contacting Rocket Elevators, but it seem that you tried to send us nasty stuff to our team.</p>
          <p>Be aware, that we take this very seriously. Please refrain from sending thing like that again or we are going to take legal action.</p>
          <p>Your IP : ' + request.remote_ip + '</p>
          <p>
          The Rocket Team
          </p>
      </body>
    </html>
    ')
    mail = SendGrid::Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    sg.client.mail._('send').post(request_body: mail.to_json)
    return redirect_to root_path, notice: "NSFW File detected, try again !"
    end
    
    if current_user && Customer.where(user_id: current_user.id).exists? 
      client = DropboxApi::Client.new(ENV['DROPBOX_OAUTH_BEARER'])
      file_path = "/#{lead_params[:FullName]}/#{file.original_filename}"
      client.upload(file_path, file.read, :mode => :add)
      lead_params = lead_params.except(:AttachedFile)
      begin  
          lead_params[:download] = client.create_shared_link_with_settings(file_path).url
      rescue => exception
          lead_params[:download] = client.list_shared_links(options = {:path => file_path}).links[0].url
      end
    else
      lead_params = lead_params.except(:AttachedFile)
      lead_params[:filename] = file.original_filename
      lead_params[:content_type] = file.content_type
      lead_params[:file_contents] = file.read
        lead_params[:download] = "To download the attached file, click on :  Show in app"
    end

    # Sendgrid
    from = SendGrid::Email.new(email: ENV['SENGRID_FROM'])
    to = SendGrid::Email.new(email: lead_params[:Email])
    subject = 'Greeting from Rocket Elevators'
    content = SendGrid::Content.new(type: 'text/html', value:'
    <html>
      <body>
          <p><img width="500px" src="' +"https://rocket-elevators.frederic2ec.tk" +ActionController::Base.helpers.image_url("rocket_elevators/logo.png") + '" /></p>
          
          <p><a>Greetings '+ lead_params[:FullName] +'</a></p>
          <p>We thank you for contacting Rocket Elevators to discuss the opportunity to contribute to your project '+ lead_params[:ProjectName]+'.</p>
          <p>A representative from our team will be in touch with you very soon. We look forward to demonstrate the value of our solutions and help you choose the appropriate product given your requirements.</p>
          <p>
          We’ll Talk soon
          </p>
          <p>
          The Rocket Team
          </p>
      </body>
    </html>
    ')
    mail = SendGrid::Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    sg.client.mail._('send').post(request_body: mail.to_json)

    # Save lead
    @lead = Lead.create(lead_params)
    @lead.save!

    # Zendesk
    ZendeskAPI::Ticket.create!($client,
      :subject =>  "#{lead_params[:FullName]} from #{lead_params[:CompanyName]}",
       :comment => { 
         :value => "
         The contact #{lead_params[:FullName]} from company #{lead_params[:CompanyName]} can be reached at email #{lead_params[:Email]} and at phone number #{lead_params[:Phone]}. 
         #{lead_params[:Department]} has a project named #{lead_params[:ProjectName]} which would require contribution from Rocket Elevators. 
         #{lead_params[:ProjectDesc]}
         Attached Message: #{lead_params[:Message]}
         The Contact uploaded an attachment

         Lead ID : ##{@lead.id}
         "
       },
       :requester => { 
         "name": lead_params[:FullName], 
         "email": lead_params[:Email]
     },
         :priority => "normal",
         :type => "question"
       )

    # Redirect to confirm
    redirect_to root_path
  end
  def download_lead
    lead = Lead.find(params[:id])
   
    data = lead.file_contents
    send_data(data, :type => lead.content_type, :filename => lead.filename, :disposition => 'download')
  end
  

  def star_wars
    resource = [{ "name" => "films", "quantity" => 6, "field" => ["director", "producer"]}, { "name" => "planets", "quantity" => 60, "field" => ["climate", "diameter"]}, { "name" => "people", "quantity" => 82, "field" => ["gender", "height", "mass", "hair_color"]}, { "name" => "species", "quantity" => 37,  "field" => ["average_height", "average_lifespan", "language"]}, { "name" => "vehicles", "quantity" => 38, "field" => ["cost_in_credits", "cargo_capacity", "manufacturer"]}, { "name" => "starships", "quantity" => 35, "field" => ["cargo_capacity", "cost_in_credits", "manufacturer"]}]
    
    rand_resource = resource.sample
    res = HTTParty.get("https://swapi.dev/api/#{rand_resource["name"]}/#{rand(1..rand_resource["quantity"])}")
    
    json = JSON.parse(res.body)
    
    rand_field = rand_resource["field"].sample
    
    fact = ""
    case rand_resource["name"]
    when "films"
        fact =  "Star Wars fact : The movie #{json["title"]} #{rand_field.gsub("_"," ")} is #{json[rand_field]}."
    when "planets"
        fact = "Star Wars fact : The planet #{json["name"]} #{rand_field.gsub("_"," ")} is #{json[rand_field]}."
    when "people"
        fact = "Star Wars fact : The character #{json["name"]} #{rand_field.gsub("_"," ")} is #{json[rand_field]}."
    when "species"
        fact = "Star Wars fact : The specie #{json["name"]} #{rand_field.gsub("_"," ")} is #{json[rand_field]}."
    when "vehicles"
        fact = "Star Wars fact : The vehicle #{json["name"]} #{rand_field.gsub("_"," ")} is #{json[rand_field]}."
    when "starships"
        fact = "Star Wars fact : The starship #{json["name"]} #{rand_field.gsub("_"," ")} is #{json[rand_field]}."
    end

    authenticator = IBMWatson::Authenticators::IamAuthenticator.new(
      apikey: ENV["WATSON_KEY"],
    )
    text_to_speech = IBMWatson::TextToSpeechV1.new(
      authenticator: authenticator
    )
    text_to_speech.service_url = ENV["WATSON_URL"]
    File.open(Rails.root.join('app', 'assets', 'audios', 'starwars.mp3'), "wb") do |audio_file|
      response = text_to_speech.synthesize(
        text: fact,
        accept: "audio/mpeg",
        voice: "en-US_AllisonVoice"
      ).result
      audio_file.write(response)
  end
  end
end

