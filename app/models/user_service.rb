class UserService < ActiveRecord::Base
  serialize :credentials, Hash

  belongs_to :user
  validates :user, presence: true
end
