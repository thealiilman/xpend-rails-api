FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(nil, ['_']) }
    sequence(:email) { |n| "user#{n}@email.com" }
    password { 'password' }
  end
end
