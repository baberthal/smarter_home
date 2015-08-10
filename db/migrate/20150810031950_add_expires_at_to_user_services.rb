class AddExpiresAtToUserServices < ActiveRecord::Migration
  def change
    add_column :user_services, :expires_at, :datetime
  end
end
