FactoryBot.define do
  factory :order do
    customer
    account { customer.account }
  end
end
