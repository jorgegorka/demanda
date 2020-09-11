# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { Faker::Coffee.blend_name }
    summary { Faker::ChuckNorris.fact }
    meta_title { Faker::Superhero.name }
    account
  end
end
