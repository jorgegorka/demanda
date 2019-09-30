FactoryBot.define do
  factory :customer do
    account
    name { Faker::DcComics.name }
  end
end
