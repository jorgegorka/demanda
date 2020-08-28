# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    account
    user
    language
    for_product
    description { Faker::Restaurant.review }

    trait :for_product do
      association :commentable, factory: :product
      rating { Faker::Number.within(range: 0..5) }
    end

    trait :with_verified_purchase do
      verified_purchase { true }
    end

    trait :with_reply do
      reply_description { Faker::Restaurant.description }
      replied_at { 3.days.from_now }
    end
  end
end
