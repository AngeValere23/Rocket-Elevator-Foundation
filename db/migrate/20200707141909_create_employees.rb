class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.references :user, foreign_key: true
      t.string :lastname
      t.string :firstname
      t.string :title

      t.timestamps
    end
  end
end
