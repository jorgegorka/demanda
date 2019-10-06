FactoryBot.define do
  factory :coupon do
    type { 'Coupon' }
    account
    name { Faker::Science.element }
    amount { (rand * 1000).round(2) }
    code { Faker::Code.nric }
    factory :coupon_with_percentage do
      percentage {  (rand * 100).round(2) }
      amount { 0 }
    end
  end
end
