class CreateLeads < ActiveRecord::Migration[5.2]
  def change
    create_table :leads do |t|
      t.string :FullName
      t.string :CompanyName
      t.string :Email
      t.string :Phone
      t.string :ProjectName
      t.string :ProjectDesc
      t.string :Department
      t.text :Message
      t.string :filename
      t.string :content_type
      t.binary :file_contents, limit: 160000000
      t.string :download

      t.timestamps
    end
  end
end
