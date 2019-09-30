# frozen_string_literal: true

FactoryBot.define do
  factory :tax do
    account
    name { Faker::Science.element }
    percentage { Faker::Number.decimal(2, 2) }
    start_at { DateTime.current.beginning_of_year }

    factory :tax_with_amount do
      percentage { 0 }
      amount { Faker::Number.decimal(3, 2) }
    end
  end
end
