FactoryBot.define do
  factory :order do
    user
    account { user.account }
  end
end
