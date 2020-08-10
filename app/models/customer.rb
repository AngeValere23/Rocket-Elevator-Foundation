class Customer < ApplicationRecord
    belongs_to :user
    belongs_to :address

    has_one :building
end
