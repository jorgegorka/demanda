# frozen_string_literal: true

module Types
  class CouponType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :name, String, null: false
    field :code, String, null: false
    field :product, Types::ProductType, null: true
    field :category, Types::CategoryType, null: true
    field :user, Types::UserType, null: true
    field :active, Boolean, null: false
    field :single_use, Boolean, null: false
    field :percentage, Float, null: true
    field :amount, Integer, null: true
    field :start_at, GraphQL::Types::ISO8601DateTime, null: false
    field :end_at, GraphQL::Types::ISO8601DateTime, null: true
    field :minimum_quantity, Float, null: true
    field :minimum_price, Float, null: true
  end
end
