class Battery < ApplicationRecord
  belongs_to :building
  belongs_to :employee
  
  has_one :column
  has_many :intervention, foreign_key: :BatteryID
end
