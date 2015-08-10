class RemoveFieldsFromUserServices < ActiveRecord::Migration
  def change
    remove_column :user_services, :available_service_id, :string
    remove_column :user_services, :service_client_id, :string
    remove_column :user_services, :service_client_secret, :string
  end
end
