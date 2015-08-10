FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "shhitsasecret"
    password_confirmation "shhitsasecret"
    confirmed_at Date.today
  end
end
