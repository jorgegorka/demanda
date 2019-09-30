module Types
  class AccountType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :invoice_address, Types::AddressType, null: true
  end
end
