# frozen_string_literal: true

FactoryBot.define do
  factory :language do
    account
    name { Faker::Coffee.blend_name }
    code { Faker::Nation.language[0, 2] }
  end
end
