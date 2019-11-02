FactoryBot.define do
  factory :cart do
    account

    factory :cart_with_customer do
      customer
    end
  end
end