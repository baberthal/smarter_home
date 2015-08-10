class AddFullHashToUserServices < ActiveRecord::Migration
  def change
    add_column :user_services, :full_auth_hash, :text
  end
end
