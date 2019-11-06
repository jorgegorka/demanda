FactoryBot.define do
  factory :language do
    account
    name { Faker::Coffee.blend_name }
  end
end