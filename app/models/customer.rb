class Customer < ApplicationRecord
    belongs_to :user
    belongs_to :address

    has_one :building
    has_many :intervention, foreign_key: :CustomerID
end
