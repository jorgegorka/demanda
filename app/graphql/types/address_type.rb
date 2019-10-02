module Types
  class AddressType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :address1, String, null: true
    field :address2, String, null: true
    field :postalCode, String, null: true
    field :city, String, null: true
    field :state, String, null: true
    field :country, String, null: true
  end
end
