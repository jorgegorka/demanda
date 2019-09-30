FactoryBot.define do
  factory :order_item do
    order
    product
    quantity_cents { Faker::Number.number(3) }
    price_cents { Faker::Number.decimal(2, 2) }
  end
end
