class CreateInterventions < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      t.bigint :AuthorID, foreign_key: { to_table: :employees }, :null => false
      t.references :CustomerID, foreign_key: { to_table: :customers }, :null => false
      t.references :BuildingID, foreign_key: { to_table: :buildings }, :null => false
      t.references :BatteryID, foreign_key: { to_table: :batteries }, :null => true
      t.references :ColumnID, foreign_key: { to_table: :columns }, :null => true
      t.references :ElevatorID, foreign_key: { to_table: :elevators }, :null =>true
      t.references :EmployeeID, foreign_key: { to_table: :employees }, :null => false
      t.datetime :InterventionStart, :null => true
      t.datetime :InterventionEnd, :null => true
      t.string :Result, :default=>"incomplete",:null => true
      t.string :Report, :null => true
      t.string :Status, :default =>"pending"

      t.timestamps
    end
  end
end
