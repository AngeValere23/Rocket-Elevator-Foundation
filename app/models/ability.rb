# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if Employee.where(user_id: user.id).exists?
      can :manage, :all
    elsif Customer.where(user_id: user.id).exists?
      can :access, :rails_admin
      can :read, :dashboard
      can :index, User,["id = ?", user.id] do |user|
        user.present?
      end
      can :index, Customer, user_id: user.id
      can :index, Elevator, ["column_id = ?", user.customer.building.battery.column.id] do |elevator|
        elevator.present?
      end
      can :index, Building, ["customer_id = ?", user.customer.id] do |building|
        building.present?
      end
      can :index, Battery,["building_id = ?", user.customer.building.id] do |battery|
      battery.present?
      end
      can :index, BuildingDetail, ["building_id = ?", user.customer.building.id] do |detail|
       detail.present?
      end
      can :index, Column,["battery_id = ?", user.customer.building.battery.id] do |column|
        column.present?
      end
    else
      return
    end
  end
end
