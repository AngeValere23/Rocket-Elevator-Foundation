module Types
    class InterventionType < Types::BaseObject
        field :id, ID, null: false
        field :building, Types::BuildingType, null: false
        field :intervention_start, String, null: false
        field :intervention_end, String, null: false


        def building
            buildingResult = Building.find(FactIntervention.find(object.id).BuildingID)
      
            buildingStruct = OpenStruct.new({:id => buildingResult.id})
            buildingStruct
        end

        field :employee, Types::EmployeeType, null: false

        def employee
            employeeResult = Employee.find(FactIntervention.find(object.id).EmployeeID)
      
            employeeStruct = OpenStruct.new({:id => employeeResult.id, :title => employeeResult.title, :first_name => employeeResult.firstname, :last_name => employeeResult.lastname})
            employeeStruct
        end
    end
end