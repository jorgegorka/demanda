module Types
  class CartType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :customer, Types::CustomerType, null: true
    field :gross_total, Float, null: false, description: 'Gross total'
    field :total_discount, Float, null: false, description: 'Total discount'
    field :total_tax, Float, null: false, description: 'Total tax'
    field :total, Float, null: false, description: 'Total cart'
    field :cart_items, [Types::CartItemType], null: true
  end
end