class AddImageAndDescriptionToService < ActiveRecord::Migration
  def change
    add_column :user_services, :image, :string
    add_column :user_services, :description, :text
  end
end
