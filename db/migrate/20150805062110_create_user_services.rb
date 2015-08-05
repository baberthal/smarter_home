class CreateUserServices < ActiveRecord::Migration
  def change
    create_table :user_services do |t|
      t.belongs_to :user
      t.belongs_to :available_service
      t.string :service_client_id
      t.string :service_client_secret

      t.timestamps null: false
    end
  end
end
