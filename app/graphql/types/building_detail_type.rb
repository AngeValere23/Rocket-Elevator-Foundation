module Types
    class BuildingDetailType < Types::BaseObject
        field :id, ID, null: false
        field :key, String, null: false
        field :value, String, null: false
    end
end