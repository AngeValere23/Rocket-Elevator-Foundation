module Types
    class EmployeeType < Types::BaseObject
        field :id, ID, null: false
        field :last_name, String, null: false
        field :first_name, String, null: false
        field :title, String, null: false
        field :interventions, [Types::InterventionType], null: false

        def interventions
            interventionArr = Array.new

            FactIntervention.where(EmployeeID: object.id).each do |interventionResult|
              interventionStruct = OpenStruct.new({:id => interventionResult.id,:intervention_start => interventionResult.InterventionStart,:intervention_end => interventionResult.InterventionEnd})
              interventionArr.push(interventionStruct)
            end
      
            interventionArr
        end
    end
end