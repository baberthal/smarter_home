class AddServiceToUserServices < ActiveRecord::Migration
  def change
    add_column :user_services, :service, :string
  end
end
