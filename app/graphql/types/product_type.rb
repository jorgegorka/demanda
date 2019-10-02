module Types
  class ProductType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :name, String, null: false
    field :category, Types::CategoryType, null: true
    field :description, String, null: true
    field :price, Integer, null: false, method: :price_cents, description: 'Price is an integer with cents included. Example: 1 euro is returned as 100.'
    field :stock, Integer, null: false
  end
end
