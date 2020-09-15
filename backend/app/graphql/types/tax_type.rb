# frozen_string_literal: true

module Types
  class TaxType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :name, String, null: false
    field :product, Types::ProductType, null: true
    field :category, Types::CategoryType, null: true
    field :user, Types::UserType, null: true
    field :product_id, String, null: true
    field :category_id, String, null: true
    field :user_id, String, null: true
    field :active, Boolean, null: true
    field :percentage, Float, null: true
    field :amount, Integer, null: true
    field :start_at, GraphQL::Types::ISO8601DateTime, null: false
    field :end_at, GraphQL::Types::ISO8601DateTime, null: true
    field :minimum_price, Float, null: true
  end
end
