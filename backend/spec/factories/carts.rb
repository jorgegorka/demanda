# frozen_string_literal: true

FactoryBot.define do
  factory :cart do
    account

    factory :cart_with_user do
      user
    end
  end
end
