FactoryBot.define do
  factory :customer do
    account
    language
    name { Faker::DcComics.name }
  end
end
