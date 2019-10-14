module Types
  class AccountType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :name, String, null: false
    field :addresses, [Types::AddressType], null: true
  end
end
