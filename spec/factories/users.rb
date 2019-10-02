FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
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
