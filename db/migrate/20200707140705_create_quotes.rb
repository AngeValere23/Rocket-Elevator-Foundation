class CreateQuotes < ActiveRecord::Migration[5.2]
  def change
    create_table :quotes do |t|
      t.string :fullname
      t.string :email
      t.string :phone
      t.string :businessname
      t.string :projectname
      t.string :buildingtype
      t.string :quality
      t.integer :nbapartment
      t.integer :nbfloor
      t.integer :nbbasement
      t.integer :nbbusiness
      t.integer :nbparking
      t.integer :nbshaft
      t.integer :nboccupant
      t.integer :nbcompanies
      t.integer :activehours
      t.integer :nbelevator
      t.string :elevatorprice
      t.string :subtotal
      t.string :installfee
      t.string :total

      t.timestamps
    end
  end
end
