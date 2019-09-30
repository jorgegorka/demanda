FactoryBot.define do
  factory :order_item do
    order
    product
    quantity_cents { Faker::Number.number(3) }
    price_cents { Faker::Number.decimal(2, 2) }

    factory :order_item_without_modifiers do
      after(:build) { |order_item| order_item.class.skip_callback(:create, :after, :add_modifiers) }
    end
  end
end
