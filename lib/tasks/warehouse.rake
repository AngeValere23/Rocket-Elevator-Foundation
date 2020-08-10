namespace :warehouse do
  desc "Seed data from the DB to the warehouse"
  task seed: :environment do

  # FactQuote
  FactQuote.delete_all
  Quote.all.each do |quote|
    FactQuote.create(:QuoteId => quote.id, :CreationDate => quote.created_at, :EnterpriseName => quote.businessname, :Email => quote.email, :NbElevator => quote.nbelevator)
  end

  # FactContact
  FactContact.delete_all
  Lead.all.each do |lead| 
    FactContact.create(:ContactId => lead.id, :CreationDate => lead.created_at, :EnterpriseName => lead.CompanyName, :Email => lead.Email, :ProjectName => lead.ProjectName)
  end

  # FactElevator
  FactElevator.delete_all
  Elevator.all.each do |elevator|
    FactElevator.create(:SerialNumber => elevator.serialNumber, :CommissioningDate => elevator.DateOfCommissioning, :BuildingId => elevator.column.battery.building.id, :CustomerId => elevator.column.battery.building.customer.id, :City => elevator.column.battery.building.address.City)
  end

  # DimCustomer
  DimCustomer.delete_all
  Customer.all.each do |customer|
    DimCustomer.create(:CreationDate => customer.created_at, :EnterpriseName => customer.CompanyName, :ContactFullname => customer.FullNameOfContact, :ContactEmail => customer.EmailOfContact, :NbElevator => Elevator.where(column: customer.building.battery.column).count, :City => customer.address.City)
  end

  # FactIntervention
  employee_id_for_intervention = [*1..27]
  result_for_intervention = ["success", "failure", "incomplete"]
  statut_for_intervention = ["pending", "inProgress", "interrupted", "resumed", "complete"]

  FactIntervention.delete_all
  Building.all.each do |building|
    FactIntervention.create(:EmployeeID => employee_id_for_intervention.delete(employee_id_for_intervention.sample), :BuildingID => building.id, :BatteryID => building.battery.id, :ColumnID => building.battery.column.id, :ElevatorID => building.battery.column.elevator.id, :InterventionStart => Faker::Date.between(from: 2.years.ago, to: Date.today), :InterventionEnd => Faker::Date.between(from: 1.years.ago, to: Date.today), :Result => result_for_intervention.sample,:Rapport => Faker::Types.rb_string, :Statut => statut_for_intervention.sample)
  end

  puts "Warehouse updated !"
  end
end
