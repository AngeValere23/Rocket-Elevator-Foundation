class CreateBatteries < ActiveRecord::Migration[5.2]
  def change
    create_table :batteries do |t|
      t.references :building, foreign_key: true
      t.string :PropertyType
      t.string :Status
      t.references :employee, foreign_key: true
      t.datetime :DateOfCommissioning
      t.datetime :DateOfLastInspect
      t.string :CertificateOfOperation

      t.timestamps
    end
  end
end
