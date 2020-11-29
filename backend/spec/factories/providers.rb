# frozen_string_literal: true

FactoryBot.define do
  factory :provider do
    account
    name { Faker::DcComics.villain }
  end
end
