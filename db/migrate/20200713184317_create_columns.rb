class CreateColumns < ActiveRecord::Migration[5.2]
  def change
    create_table :columns do |t|
      t.references :battery, foreign_key: true
      t.string :PropertyType
      t.string :NumberOfFloor
      t.string :Status
      t.string :Informations
      t.text :Notes

      t.timestamps
    end
  end
end
