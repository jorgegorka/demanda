module Types
  class UserType < BaseObject
    field :uuid, String, null: true
    field :email, String, null: true
    field :account, Types::AccountType, null: false
    field :customer, Types::CustomerType, null: true
  end
end
