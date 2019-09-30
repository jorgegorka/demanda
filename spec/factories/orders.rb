FactoryBot.define do
  factory :order do
    customer
    account { customer.account }

    factory :order_without_modifiers do
      after(:build) { |order| order.class.skip_callback(:create, :after, :add_modifiers) }
    end
  end
end
