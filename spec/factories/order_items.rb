FactoryBot.define do
  factory :order_item do
    order
    product
    quantity { (rand * 1000).round }
    price { product.price }
    total_tax { 0 }
    total_discount { 0 }
    price_includes_taxes { false }

    factory :order_item_without_modifiers do
      after(:build) { |order_item| order_item.class.skip_callback(:create, :after, :add_modifiers) }
    end
  end
end
