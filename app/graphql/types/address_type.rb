module Types
    class AddressType < Types::BaseObject
        field :id, ID, null: false
        field :type_of_address, String, null: false
        field :status, String, null: false
        field :entity, String, null: false
        field :number_and_street, String, null: false
        field :suite_or_appart, String, null: false
        field :city, String, null: false
        field :country, String, null: false
    end
end