# frozen_string_literal: true

FactoryBot.define do
  factory :account do
    name { Faker::Company.name }
    domain { "http://#{Faker::Internet.domain_name}" }
  end
end
