module Types
  class UserType < BaseObject
    field :id, String, null: false, method: :uuid
    field :email, String, null: true
    field :account, Types::AccountType, null: false
    field :customer, Types::CustomerType, null: true
  end
end
