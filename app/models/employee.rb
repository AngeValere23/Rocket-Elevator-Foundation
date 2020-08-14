class Employee < ApplicationRecord
  belongs_to :user
  has_one :battery

  def fullname
    "#{self.firstname}  #{self.lastname}"
   end

   has_many :intervention, foreign_key: :AuthorID
   has_many :intervention, foreign_key: :EmployeeID
end
