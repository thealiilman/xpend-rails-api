FactoryBot.define do
  factory :expense_category do
    title { Faker::Movies::HarryPotter.spell }
  end
end
