class CreateElevators < ActiveRecord::Migration[5.2]
  def change
    create_table :elevators do |t|
      t.references :column, foreign_key: true
      t.string :serialNumber
      t.string :Model
      t.string :PropertyType
      t.string :Status
      t.datetime :DateOfCommissioning
      t.datetime :DateOfLastInspection
      t.string :CertificateOfInpection
      t.string :Information
      t.text :Notes

      t.timestamps
    end
  end
end
