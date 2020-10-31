# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    account
    name { Faker::DcComics.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    phone { Faker::PhoneNumber.cell_phone }

    factory :admin do
      role { :admin }
    end

    factory :manager do
      role { :manager }
    end
  end
end
