FactoryBot.define do
  factory :order_item do
    order
    product
    quantity { (rand * 1000).round }
    price { product.price }
    total_tax { 0 }
    total_discount { 0 }
    price_includes_taxes { false }
  end
end
