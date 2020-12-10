# frozen_string_literal: true

module Types
  class Order < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :status, Types::OrderStatusEnum, null: false
    field :user, Types::User, null: false
    field :total_tax, Float, null: false
    field :total_discount, Float, null: false
    field :total, Float, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :order_items, [Types::OrderItem], null: true
  end
end
