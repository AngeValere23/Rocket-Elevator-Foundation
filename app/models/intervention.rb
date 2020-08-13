class Intervention < ApplicationRecord

    belongs_to :customer, optional: true
    belongs_to :building, optional: true
    belongs_to :battery, optional: true
    belongs_to :column, optional: true
    belongs_to :elevator, optional: true
    belongs_to :employee,optional: true

    # belongs_to :AuthorID, class_name: 'Employee'
    # belongs_to :CustomerID, class_name: 'Customer'
    # belongs_to :BuildingID, class_name: 'Building'
    # belongs_to :BatteryID, class_name: 'Battery'
    # belongs_to :ColumnID, class_name: 'Column'
    # belongs_to :ElevatorID, class_name: 'Elevator'
    # belongs_to :EmployeeID, class_name: 'Employee'

    # belongs_to :AuthorID, class_name: "Employee"
    # belongs_to :customer
    # belongs_to :building
    # belongs_to :battery
    # belongs_to :column, optional: true
    # belongs_to :elevator, optional: true
    # belongs_to :employee, optional: true
end
