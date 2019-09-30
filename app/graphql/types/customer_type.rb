module Types
  class CustomerType < Types::BaseObject
    field :uuid, String, null: false
    field :name, String, null: false
  end
end
