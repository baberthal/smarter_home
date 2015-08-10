class RenameColumnsUserServices < ActiveRecord::Migration
  def change
    rename_column :user_services, :auth_token, :credentials
  end
end
