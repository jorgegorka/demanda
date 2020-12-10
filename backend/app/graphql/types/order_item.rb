# frozen_string_literal: true

module Types
  class OrderItem < Types::BaseObject
    field :id, String, null: false, method: :uuid, description: 'Order id'
    field :order, Types::Order, null: false
    field :product, Types::Product, null: false
    field :price, Float, null: false, description: 'Product price'
    field :quantity, Float, null: false, description: 'Product quantity'
    field :total_gross, Float, null: false, description: 'Gross total'
    field :total_net, Float, null: false, description: 'Net total'
    field :total_discount, Float, null: false, description: 'Total discount'
    field :total_tax, Float, null: false, description: 'Total tax'
    field :total, Float, null: false, description: 'Total'
  end
end
