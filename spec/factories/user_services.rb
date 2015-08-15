FactoryGirl.define do
  factory :user_service do
    user
    service { %w( Nest Trakt Google ).sample }
    credentials {}
  end

  factory :user_service_with_credentials, parent: :user_service do
    credentials { { authorization_code: Faker::Number.hexadecimal(25) } }
  end
end
