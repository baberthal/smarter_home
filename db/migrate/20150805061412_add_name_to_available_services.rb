class AddNameToAvailableServices < ActiveRecord::Migration
  def change
    add_column :available_services, :name, :string
  end
end
