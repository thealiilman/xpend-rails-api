FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(2..16, ['_']) }
    sequence(:email) { |n| "user#{n}@email.com" }
    password { 'password' }
  end
end
