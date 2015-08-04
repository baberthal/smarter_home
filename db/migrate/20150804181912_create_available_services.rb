class CreateAvailableServices < ActiveRecord::Migration
  def change
    create_table :available_services do |t|


      t.timestamps null: false
    end
  end
end
