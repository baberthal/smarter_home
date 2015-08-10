module Auth
  class Base < ActionController::Base
    include Devise::Controllers::Helpers
  end
end
