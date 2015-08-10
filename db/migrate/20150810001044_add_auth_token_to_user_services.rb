class AddAuthTokenToUserServices < ActiveRecord::Migration
  def change
    add_column :user_services, :auth_token, :text
  end
end
