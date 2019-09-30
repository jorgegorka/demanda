FactoryBot.define do
  factory :category do
    name { Faker::Coffee.blend_name }
    account
  end
end
