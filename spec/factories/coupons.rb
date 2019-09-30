FactoryBot.define do
  factory :coupon do
    type { 'Coupon' }
    account
    name { Faker::Science.element }
    amount { Faker::Number.decimal(3, 2) }
    code { Faker::Code.nric }
    factory :coupon_with_percentage do
      percentage { Faker::Number.decimal(2, 2) }
      amount { 0 }
    end
  end
end
