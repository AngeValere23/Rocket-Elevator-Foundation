# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Employee.destroy_all


# Create the needed users
ngenest = User.create(:email => "nicolas.genest@codeboxx.biz", :password => "rocket", :password_confirmation => "rocket")
nfortier = User.create(:email => "nadya.fortier@codeboxx.biz", :password => "rocket", :password_confirmation => "rocket")
mchantal = User.create(:email => "martin.chantal@codeboxx.biz", :password => "rocket", :password_confirmation => "rocket")
mhoude = User.create(:email => "mathieu.houde@codeboxx.biz", :password => "rocket", :password_confirmation => "rocket")
dboutin = User.create(:email => "david.boutin@codeboxx.biz", :password => "rocket", :password_confirmation => "rocket")
mlortie = User.create(:email => "mathieu.lortie@codeboxx.biz", :password => "rocket", :password_confirmation => "rocket")
tcarrier = User.create(:email => "thomas.carrier@codeboxx.biz", :password => "rocket", :password_confirmation => "rocket")

# Create some employees
Employee.create(:user_id => ngenest.id, :lastname => "Genest", :firstname => "Nicolas", :title => "Comm Rep")
Employee.create(:user_id => nfortier.id, :lastname => "Fortier", :firstname => "Nadya", :title => "Director")
Employee.create(:user_id => mchantal.id, :lastname => "Chantal", :firstname => "Martin", :title => "Director Assistant")
Employee.create(:user_id => mhoude.id, :lastname => "Houde", :firstname => "Mathieu", :title => "Captain")
Employee.create(:user_id => dboutin.id, :lastname => "Boutin", :firstname => "David", :title => "Engineer")
Employee.create(:user_id => mlortie.id, :lastname => "Lortie", :firstname => "Mathieu", :title => "Engineer")
Employee.create(:user_id => tcarrier.id, :lastname => "Carrier", :firstname => "Thomas", :title => "Engineer")

# Create random employees with users
20.times {
    user = User.create(:email => Faker::Internet.email, :password => "rocket", :password_confirmation => "rocket")
    Employee.create(:user_id => user.id, :lastname => Faker::Name.last_name, :firstname => Faker::Name.last_name, :title => Faker::Construction.role)
}

# Create random users for customers
20.times {
    User.create(:email => Faker::Internet.email, :password => "rocket", :password_confirmation => "rocket")
}

p "Created #{User.count} users"
p "Created #{Employee.count} employees"


# Create leads
100.times {
    Lead.create(:FullName => Faker::Name.name, :CompanyName => Faker::Company.name, :Email => Faker::Internet.email, :Phone => Faker::PhoneNumber.phone_number, :ProjectName => Faker::Company.industry, :ProjectDesc => Faker::Company.type, :Message => Faker::Construction.subcontract_category, :Department => Faker::Commerce.department, :created_at => Faker::Date.between(from: 2.years.ago, to: Date.today))
}

p "Create #{Lead.count} leads"


# Define some sample type
building_type = ["Residential", "Commercial", "Corporate", "Hybrid"]
service_quality = ["Standard", "Premium", "Excelium"]

# Create quotes
100.times {
    Quote.create(:fullname => Faker::Name.name, :email => Faker::Internet.email, :phone => Faker::PhoneNumber.phone_number, :businessname => Faker::Company.name, :projectname => Faker::Company.industry, :quality => service_quality.sample, :buildingtype => building_type.sample, :nbapartment => Faker::Number.digit, :nbfloor => Faker::Number.digit, :nbbasement => Faker::Number.digit, :nbbusiness => Faker::Number.digit, :nbparking => Faker::Number.digit, :nbshaft => Faker::Number.digit, :nboccupant => Faker::Number.digit, :nbcompanies => Faker::Number.digit, :activehours => Faker::Number.digit, :nbelevator => Faker::Number.digit, :elevatorprice => Faker::Commerce.price, :subtotal => Faker::Commerce.price, :installfee => Faker::Commerce.price, :total => Faker::Commerce.price, :created_at => Faker::Date.between(from: 2.years.ago, to: Date.today))
}

p "Create #{Quote.count} quotes"

# Create addresses
type_of_address = ["Billing", "Shipping", "Home", "Business"]
status_type = ["Active", "Inactive"]
entity_type = ["Building", "Customer"]

json_text = File.read(Rails.root.join('db', 'addresses-us-100.json'))
json = JSON.parse(json_text)

json["addresses"].each do |address|
    Address.create(:TypeOfAddress => type_of_address.sample, :Status => status_type.sample, :Entity => entity_type.sample, :NumberAndStreet => address["address1"], :SuiteOrAppart => Faker::Address.secondary_address, :City => address["city"], :PostalCode => address["postalCode"], :Country => address["state"], :Notes => Faker::Types.rb_string, :Lat => address["coordinates"]["lat"], :Lng => address["coordinates"]["lng"])
end

p "Create #{Address.count} addresses"

# Create customers
user_id_for_customer = [*28..47]
address_id_for_customer = [*1..20]

20.times {
    Customer.create(:user_id => user_id_for_customer.delete(user_id_for_customer.sample), :CompanyName => Faker::Company.name, :address_id => address_id_for_customer.delete(address_id_for_customer.sample), :FullNameOfContact => Faker::Name.name, :CompanyPhone => Faker::PhoneNumber.phone_number, :EmailOfContact => Faker::Internet.email, :FullNameOfServiceTechAuthority => Faker::Name.name, :TechnicalAuthorityPhone => Faker::PhoneNumber.phone_number, :TechnicalAuthorityEmail => Faker::Internet.email)
}

p "Create #{Customer.count} customers"

# Create buildings
customer_id_for_building = [*1..20]
address_id_for_building = [*21..40]

20.times {
    Building.create(:customer_id => customer_id_for_building.delete(customer_id_for_building.sample), :address_id => address_id_for_building.delete(address_id_for_building.sample), :BuildingAdmFullName => Faker::Name.name, :BuildingAdmEmail => Faker::Internet.email, :BuildingAdmPhone => Faker::PhoneNumber.phone_number, :BuildingTechFullName => Faker::Name.name, :BuildingTechEmail => Faker::Internet.email, :BuildingTechPhone => Faker::PhoneNumber.phone_number)
}

p "Create #{Building.count} buildings"

# Create buildings  details
building_id_for_detail = [*1..20]

20.times {
    BuildingDetail.create(:building_id => building_id_for_detail.delete(building_id_for_detail.sample), :key => Faker::Types.rb_string, :value => Faker::Types.rb_string)
}

p "Create #{BuildingDetail.count} buildings details"

# Create battery
building_id_for_battery = [*1..20]
employee_id_for_battery = [*1..20]

20.times {
    Battery.create(:building_id => building_id_for_battery.delete(building_id_for_battery.sample), :PropertyType => building_type.sample, :Status => status_type.sample, :employee_id => employee_id_for_battery.delete(employee_id_for_battery.sample), :DateOfCommissioning => Faker::Date.between(from: 2.years.ago, to: Date.today), :DateOfLastInspect => Faker::Date.between(from: 2.years.ago, to: Date.today), :CertificateOfOperation => Faker::Code.isbn)
}

p "Create #{Battery.count} batteries"

# Create columns
battery_id_for_column = [*1..20]

20.times {
    Column.create(:battery_id => battery_id_for_column.delete(battery_id_for_column.sample), :PropertyType => building_type.sample, :NumberOfFloor => Faker::Number.number(digits: 2), :Status => status_type.sample, :Informations => Faker::Types.rb_string, :Notes => Faker::Types.rb_string)
}

p "Create #{Column.count} columns"

# Create elevators
column_id_for_elevator = [*1..20]

20.times {
    Elevator.create(:column_id => column_id_for_elevator.delete(column_id_for_elevator.sample), :serialNumber => Faker::Code.isbn, :Model => service_quality.sample, :PropertyType  => building_type.sample,:Status => status_type.sample, :DateOfCommissioning => Faker::Date.between(from: 2.years.ago, to: Date.today), :DateOfLastInspection => Faker::Date.between(from: 2.years.ago, to: Date.today), :CertificateOfInpection => Faker::Code.isbn, :Information => Faker::Types.rb_string, :Notes => Faker::Types.rb_string)
}

p "Create #{Elevator.count} elevators"
