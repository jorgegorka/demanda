module Types
  class ProductType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :name, String, null: false
    field :category, Types::CategoryType, null: true
    field :description, String, null: true
    field :price, Float, null: false, description: 'Price'
    field :stock, Integer, null: false
  end
end
