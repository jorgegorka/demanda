FactoryBot.define do
  factory :translation do
    language { Faker::Address.country_code_long }
  end
end
