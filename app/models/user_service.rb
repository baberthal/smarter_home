class UserService < ActiveRecord::Base
  serialize :credentials, Hash

  belongs_to :user
  validates :user, presence: true

  def name
    service
  end

  def image
    case name
    when /nest/
      'Nest_Labs_logo.svg'
    when /trakt/
      'TraktTV_Logo.png'
    end
  end
end
