class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.references :user, foreign_key: true, type: :bigint
      t.string :CompanyName
      t.references :address, foreign_key: true
      t.string :FullNameOfContact
      t.string :CompanyPhone
      t.string :EmailOfContact
      t.string :FullNameOfServiceTechAuthority
      t.string :TechnicalAuthorityPhone
      t.string :TechnicalAuthorityEmail

      t.timestamps
    end
  end
end
