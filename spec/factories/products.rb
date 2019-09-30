FactoryBot.define do
  factory :product do
    category
    account { category.account }
    name { Faker::Vehicle.make_and_model }
    stock { Faker::Number.number(3) }
    price_cents { Faker::Number.number(6) }
  end
end
