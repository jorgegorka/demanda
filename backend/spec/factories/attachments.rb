FactoryBot.define do
  factory :attachment do
    title { Faker::Internet.username }
    url { Faker::Internet.url }
  end
end
