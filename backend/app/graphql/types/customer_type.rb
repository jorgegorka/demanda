module Types
  class UserType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :name, String, null: false
    field :cart, Types::CartType, null: true
    field :user, Types::UserType, null: true
  end
end
