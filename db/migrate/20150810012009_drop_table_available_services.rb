class DropTableAvailableServices < ActiveRecord::Migration
  def change
    drop_table :available_services
  end
end
