module Types
  class QueryType < Types::BaseObject
    # Add root-level fields here.
    # They will be entry points for queries on your schema.
    
    # Get a single intervention
    field :intervention, InterventionType, null: true do
      argument :id, ID, required: true
    end

    def intervention(id:)
      interventionResult = FactIntervention.find(id)

        interventionStruct = OpenStruct.new({:id => interventionResult.id,:intervention_start => interventionResult.InterventionStart,:intervention_end => interventionResult.InterventionEnd})
        interventionStruct
    end

    field :interventions, [InterventionType], null: true

    def interventions
      interventionArr = Array.new

      FactIntervention.all.each do |interventionResult|
        interventionStruct = OpenStruct.new({:id => interventionResult.id,:intervention_start => interventionResult.InterventionStart,:intervention_end => interventionResult.InterventionEnd})
        interventionArr.push(interventionStruct)
      end

      interventionArr
    end

    field :building, BuildingType, null: true do
      argument :id, ID, required: true
    end

    def building(id:)
      buildingResult = Building.find(id)

      buildingStruct = OpenStruct.new({:id => buildingResult.id})
      buildingStruct
    end

    field :buildings, [BuildingType], null: true

    def buildings
      buildingArr = Array.new

      FactIntervention.all.each do |buildingResult|
        buildingStruct = buildingStruct = OpenStruct.new({:id => buildingResult.id})
        buildingArr.push(buildingStruct)
      end

      buildingArr
    end

    field :employee, EmployeeType, null: true do
      argument :id, ID, required: true
    end

    def employee(id:)
      employeeResult = Employee.find(id)

      employeeStruct = OpenStruct.new({:id => employeeResult.id, :title => employeeResult.title, :first_name => employeeResult.firstname, :last_name => employeeResult.lastname})
      employeeStruct
    end

    field :employees, [EmployeeType], null: true

    def employees
      employeeArr = Array.new
      Employee.all.each do |employeeResult|
        employeeStruct = OpenStruct.new({:id => employeeResult.id, :title => employeeResult.title, :first_name => employeeResult.firstname, :last_name => employeeResult.lastname})
        employeeArr.push(employeeStruct)
      end
      employeeArr
    end
  end
end
