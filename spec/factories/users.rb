FactoryBot.define do
  factory :user do
    username { Faker::Internet.username(2..16, ['_']) }
    sequence(:email) { |n| "user#{n}@email.com" }
    password { 'password' }

    trait :requested_password_reset do
      reset_password_digest { SecureRandom.urlsafe_base64 }
      reset_password_email_sent_at { Time.current }
    end
  end
end
