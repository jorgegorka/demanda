FactoryBot.define do
  factory :discount do
    account
    name { Faker::Science.element }
    percentage { (rand * 100).round(2) }
    amount { 0 }
    start_at { DateTime.current.beginning_of_year }
    minimum_quantity { 0 }
    minimum_price { 0 }
    active { true }

    factory :discount_with_amount do
      percentage { 0 }
      amount { (rand * 1000).round(2) }
    end

    factory :discount_for_user do
      user
      account { user.account }
    end
  end
end
