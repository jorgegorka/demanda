FactoryBot.define do
  factory :language do
    name { Faker::Coffee.blend_name }
    account
  end
end