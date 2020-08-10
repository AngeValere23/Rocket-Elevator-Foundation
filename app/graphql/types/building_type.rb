module Types
    class BuildingType < Types::BaseObject
        field :id, ID, null: false
        field :address, Types::AddressType, null: true

        def address
            addressResult = Building.find(object.id).address
            addressStruct = OpenStruct.new({:id => addressResult.id, :city => addressResult.City, :country => addressResult.Country, :entity => addressResult.Entity, :number_and_street => addressResult.NumberAndStreet, :status => addressResult.Status, :suite_or_appart => addressResult.SuiteOrAppart, :type_of_address => addressResult.TypeOfAddress})
            addressStruct
        end

        field :customer, Types::CustomerType, null: true

        def customer
            customerResult = Building.find(object.id).customer
            customerStruct = OpenStruct.new({:id => customerResult.id, :company_name => customerResult.CompanyName, :company_phone => customerResult.CompanyPhone, :email_of_contact => customerResult.EmailOfContact, :full_name_of_contact => customerResult.FullNameOfContact, :full_name_of_service_tech_authority => customerResult.FullNameOfServiceTechAuthority, :technical_authority_email => customerResult.TechnicalAuthorityEmail, :technical_authority_phone => customerResult.TechnicalAuthorityPhone})
            customerStruct
        end

        field :interventions, [Types::InterventionType], null: true

        def interventions
            interventionArr = Array.new

            FactIntervention.where(BuildingID: object.id).each do |interventionResult|
              interventionStruct = OpenStruct.new({:id => interventionResult.id,:intervention_start => interventionResult.InterventionStart,:intervention_end => interventionResult.InterventionEnd})
              interventionArr.push(interventionStruct)
            end
      
            interventionArr
        end

        field :building_detail, Types::BuildingDetailType, null: true

        def building_detail
            buildingDetailResult = Building.find(object.id).building_detail
            buildingDetailStruct =  OpenStruct.new({:id =>buildingDetailResult.id, :key => buildingDetailResult.key, :value => buildingDetailResult.value})
            buildingDetailStruct
        end
    end
end