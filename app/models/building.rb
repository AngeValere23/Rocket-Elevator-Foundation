class Building < ApplicationRecord
  belongs_to :customer
  belongs_to :address

  has_one :building_detail
  has_one :battery
  has_many :intervention, foreign_key: :BuildingID
end
