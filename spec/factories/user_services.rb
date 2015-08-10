FactoryGirl.define do
  factory :user_service do
    user
    service "Nest"
    credentials {}
  end

  factory :user_service_with_credentials, parent: :user_service do
    credentials { { authorization_code: Faker::Number.hexadecimal(25) } }
  end

end
