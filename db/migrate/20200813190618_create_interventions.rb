class CreateInterventions < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      t.references :AuthorID
      t.references :CustomerID
      t.references :BuildingID
      t.references :BatteryID
      t.references :ColumnID
      t.references :ElevatorID
      t.references :EmployeeID
      t.datetime :InterventionStart, :null => true
      t.datetime :InterventionEnd, :null => true
      t.string :Result, :default=>"incomplete",:null => true
      t.string :Report
      t.string :Status, :default =>"pending"

      t.timestamps
    end
  end
end
