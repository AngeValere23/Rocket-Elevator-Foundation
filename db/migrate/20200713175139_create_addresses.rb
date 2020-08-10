class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :TypeOfAddress
      t.string :Status
      t.string :Entity
      t.string :NumberAndStreet
      t.string :SuiteOrAppart
      t.string :City
      t.string :PostalCode
      t.string :Country
      t.string :Lat
      t.string :Lng
      t.text :Notes

      t.timestamps
    end
  end
end
