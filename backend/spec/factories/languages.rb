# frozen_string_literal: true

FactoryBot.define do
  factory :language do
    account
    name { Faker::Coffee.blend_name }
    code { Faker::Alphanumeric.alphanumeric(number: 2) }
  end
end
