FactoryBot.define do
  factory :account do
    name { Faker::Company::name }
  end
end
