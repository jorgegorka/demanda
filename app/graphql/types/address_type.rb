module Types
  class AddressType < Types::BaseObject
    field :id, ID, null: false
    field :address1, String, null: true
    field :address2, String, null: true
    field :postalCode, String, null: true
    field :city, String, null: true
    field :state, String, null: true
    field :country, String, null: true
    field :account, Types::AccountType, null: true
    field :user, Types::UserType, null: true
  end
end
