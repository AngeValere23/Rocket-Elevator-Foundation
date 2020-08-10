module Types
    class CustomerType < Types::BaseObject
        field :id, ID, null: false
        field :company_name, String, null: false
        field :address, Types::AddressType, null: false
        field :full_name_of_contact, String, null: false
        field :company_phone, String, null: false
        field :email_of_contact, String, null: false
        field :full_name_of_service_tech_authority, String, null: false
        field :technical_authority_phone, String, null: false
        field :technical_authority_email, String, null: false

        def address
            addressResult = Customer.find(object.id).address
            addressStruct = OpenStruct.new({:id => addressResult.id, :city => addressResult.City, :country => addressResult.Country, :entity => addressResult.Entity, :number_and_street => addressResult.NumberAndStreet, :status => addressResult.Status, :suite_or_appart => addressResult.SuiteOrAppart, :type_of_address => addressResult.TypeOfAddress})
            addressStruct
        end
    end
end