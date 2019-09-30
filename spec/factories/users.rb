FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email(name: first_name) }
    password { Faker::Internet.password }
    account

    factory :admin do
      role { :admin }
    end

    factory :manager do
      role { :manager }
    end
  end
end
