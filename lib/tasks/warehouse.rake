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
  #employee_id_for_intervention = [*1..27]
  #result_for_intervention = ["success", "failure", "incomplete"]
  #statut_for_intervention = ["pending", "inProgress", "interrupted", "resumed", "complete"]

  FactIntervention.delete_all
  Intervention.all.each do |intervention|
    FactIntervention.create(:EmployeeID => intervention.EmployeeID.id, :BuildingID => intervention.BuildingID.id, :BatteryID => intervention.BatteryID.id, :ColumnID => intervention.ColumnID.id, :ElevatorID => intervention.ElevatorID.id, :InterventionStart => intervention.InterventionStart, :InterventionEnd => intervention.InterventionEnd, :Result => intervention.Result,:Rapport => intervention.Report, :Statut => intervention.Status)
  end

  puts "Warehouse updated !"
  end
end
