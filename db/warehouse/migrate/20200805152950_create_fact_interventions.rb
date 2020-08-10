class CreateFactInterventions < ActiveRecord::Migration[5.2]
  def change
    create_table :fact_interventions do |t|
      t.integer :EmployeeID
      t.integer :BuildingID
      t.integer :BatteryID
      t.integer :ColumnID
      t.integer :ElevatorID
      t.datetime :InterventionStart
      t.datetime :InterventionEnd
      t.string :Result
      t.text :Rapport
      t.string :Statut

      t.timestamps
    end
  end
end
