FactoryBot.define do
  factory :address do
    name { Faker::Company.name }
    address_1 {Faker::Address.street_address}
    address_2 {Faker::Address.secondary_address}
    postal_code {Faker::Address.zip_code}
    city {Faker::Address.city}
    state {Faker::Address.state}
    country { Faker::Address.country }
  end
end
