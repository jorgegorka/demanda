module Types
  class DiscountType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :name, String, null: false
    field :product, Types::ProductType, null: true
    field :category, Types::CategoryType, null: true
    field :customer, Types::CustomerType, null: true
    field :productId, String, null: true
    field :categoryId, String, null: true
    field :customerId, String, null: true
    field :active, Boolean, null: true
    field :percentage, Float, null: true
    field :amount, Integer, null: true
    field :start_at, GraphQL::Types::ISO8601DateTime, null: false
    field :end_at, GraphQL::Types::ISO8601DateTime, null: true
    field :minimum_quantity, Float, null: true
    field :minimum_price, Float, null: true
  end
end
