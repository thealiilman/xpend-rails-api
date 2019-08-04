FactoryBot.define do
  factory :expense do
    title { Faker::Movies::HarryPotter.book }
    description { Faker::Movies::HarryPotter.quote }
    amount_cents { 1000 }
    user
  end
end
