# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    name { Faker::Company.name }
    first_address {Faker::Address.street_address}
    second_address {Faker::Address.secondary_address}
    postal_code {Faker::Address.zip_code}
    city {Faker::Address.city}
    state {Faker::Address.state}
    country { Faker::Address.country }

    trait :for_user do
      association :addressable, factory: :user
    end
  end
end
