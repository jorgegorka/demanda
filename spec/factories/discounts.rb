FactoryBot.define do
  factory :discount do
    account
    name { Faker::Science.element }
    percentage { Faker::Number.decimal(2, 2) }
    start_at { DateTime.current.beginning_of_year }

    factory :discount_with_amount do
      percentage { 0 }
      amount { Faker::Number.decimal(3, 2) }
    end

    factory :discount_for_customer do
      customer
      account { customer.account }
    end
  end
end
