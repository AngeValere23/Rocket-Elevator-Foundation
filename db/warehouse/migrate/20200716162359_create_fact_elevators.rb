class CreateFactElevators < ActiveRecord::Migration[5.2]
  def change
    create_table :fact_elevators do |t|
      t.string :SerialNumber
      t.datetime :CommissioningDate
      t.string :BuildingId
      t.string :CustomerId
      t.string :City

      t.timestamps
    end
  end
end
