FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'shhitsasecret'
    password_confirmation 'shhitsasecret'
    confirmed_at Time.zone.today
  end

  factory :user_with_services, parent: :user do
    transient do
      service_count 2
    end

    after(:create) do |user, evaluator|
      create_list(:user_service, evaluator.service_count, user: user)
    end
  end
end
