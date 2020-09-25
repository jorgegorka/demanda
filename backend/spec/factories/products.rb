# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    category
    account { category.account }
    name { Faker::Vehicle.make_and_model }
    tag_names { [Faker::Commerce.color, Faker::Commerce.color] }
    stock { (rand * 1000).round }
    price { (rand * 1000).round(2) }
  end
end
