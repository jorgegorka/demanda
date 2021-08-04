# frozen_string_literal: true

FactoryBot.define do
  factory :attachment do
    title { Faker::Restaurant.name }
    order { Faker::Number.number(digits: 2) }

    trait :with_media do
      media_item { Rack::Test::UploadedFile.new('spec/files/image.png', 'image/png') }
    end
  end
end
