# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_12_172554) do

  create_table "addresses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "TypeOfAddress"
    t.string "Status"
    t.string "Entity"
    t.string "NumberAndStreet"
    t.string "SuiteOrAppart"
    t.string "City"
    t.string "PostalCode"
    t.string "Country"
    t.string "Lat"
    t.string "Lng"
    t.text "Notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "batteries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "building_id"
    t.string "PropertyType"
    t.string "Status"
    t.bigint "employee_id"
    t.datetime "DateOfCommissioning"
    t.datetime "DateOfLastInspect"
    t.string "CertificateOfOperation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["building_id"], name: "index_batteries_on_building_id"
    t.index ["employee_id"], name: "index_batteries_on_employee_id"
  end

  create_table "building_details", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "building_id"
    t.string "key"
    t.string "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["building_id"], name: "index_building_details_on_building_id"
  end

  create_table "buildings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "address_id"
    t.string "BuildingAdmFullName"
    t.string "BuildingAdmEmail"
    t.string "BuildingAdmPhone"
    t.string "BuildingTechFullName"
    t.string "BuildingTechEmail"
    t.string "BuildingTechPhone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_buildings_on_address_id"
    t.index ["customer_id"], name: "index_buildings_on_customer_id"
  end

  create_table "columns", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "battery_id"
    t.string "PropertyType"
    t.string "NumberOfFloor"
    t.string "Status"
    t.string "Informations"
    t.text "Notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["battery_id"], name: "index_columns_on_battery_id"
  end

  create_table "customers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "CompanyName"
    t.bigint "address_id"
    t.string "FullNameOfContact"
    t.string "CompanyPhone"
    t.string "EmailOfContact"
    t.string "FullNameOfServiceTechAuthority"
    t.string "TechnicalAuthorityPhone"
    t.string "TechnicalAuthorityEmail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_customers_on_address_id"
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "elevators", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "column_id"
    t.string "serialNumber"
    t.string "Model"
    t.string "PropertyType"
    t.string "Status"
    t.datetime "DateOfCommissioning"
    t.datetime "DateOfLastInspection"
    t.string "CertificateOfInpection"
    t.string "Information"
    t.text "Notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["column_id"], name: "index_elevators_on_column_id"
  end

  create_table "employees", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id"
    t.string "lastname"
    t.string "firstname"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "interventions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "AuthorID", null: false
    t.bigint "CustomerID_id"
    t.bigint "BuildingID_id"
    t.bigint "BatteryID_id"
    t.bigint "ColumnID_id"
    t.bigint "ElevatorID_id"
    t.bigint "EmployeeID_id"
    t.datetime "InterventionStart"
    t.datetime "InterventionEnd"
    t.string "Result"
    t.string "Report"
    t.string "Status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["AuthorID"], name: "index_interventions_on_AuthorID"
    t.index ["BatteryID_id"], name: "index_interventions_on_BatteryID_id"
    t.index ["BuildingID_id"], name: "index_interventions_on_BuildingID_id"
    t.index ["ColumnID_id"], name: "index_interventions_on_ColumnID_id"
    t.index ["CustomerID_id"], name: "index_interventions_on_CustomerID_id"
    t.index ["ElevatorID_id"], name: "index_interventions_on_ElevatorID_id"
    t.index ["EmployeeID_id"], name: "index_interventions_on_EmployeeID_id"
  end

  create_table "leads", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "FullName"
    t.string "CompanyName"
    t.string "Email"
    t.string "Phone"
    t.string "ProjectName"
    t.string "ProjectDesc"
    t.string "Department"
    t.text "Message"
    t.string "filename"
    t.string "content_type"
    t.binary "file_contents", limit: 4294967295
    t.string "download"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "quotes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "fullname"
    t.string "email"
    t.string "phone"
    t.string "businessname"
    t.string "projectname"
    t.string "buildingtype"
    t.string "quality"
    t.integer "nbapartment"
    t.integer "nbfloor"
    t.integer "nbbasement"
    t.integer "nbbusiness"
    t.integer "nbparking"
    t.integer "nbshaft"
    t.integer "nboccupant"
    t.integer "nbcompanies"
    t.integer "activehours"
    t.integer "nbelevator"
    t.string "elevatorprice"
    t.string "subtotal"
    t.string "installfee"
    t.string "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "batteries", "buildings"
  add_foreign_key "batteries", "employees"
  add_foreign_key "building_details", "buildings"
  add_foreign_key "buildings", "addresses"
  add_foreign_key "buildings", "customers"
  add_foreign_key "columns", "batteries"
  add_foreign_key "customers", "addresses"
  add_foreign_key "customers", "users"
  add_foreign_key "elevators", "columns"
  add_foreign_key "employees", "users"
  add_foreign_key "interventions", "batteries", column: "BatteryID_id"
  add_foreign_key "interventions", "buildings", column: "BuildingID_id"
  add_foreign_key "interventions", "columns", column: "ColumnID_id"
  add_foreign_key "interventions", "customers", column: "CustomerID_id"
  add_foreign_key "interventions", "elevators", column: "ElevatorID_id"
  add_foreign_key "interventions", "employees", column: "EmployeeID_id"
end
