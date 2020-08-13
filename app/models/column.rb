class Column < ApplicationRecord
    belongs_to :battery

    has_one :elevator
    has_many :intervention, foreign_key: :ColumnID
end
