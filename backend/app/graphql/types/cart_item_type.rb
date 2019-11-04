module Types
  class CartItemType < Types::BaseObject
    field :id, String, null: false, method: :uuid, description: 'Cart id'
    field :product, Types::ProductType, null: true
    field :price, Float, null: false, description: 'Product price'
    field :quantity, Float, null: false, description: 'Product quantity'
    field :gross_total, Float, null: false, description: 'Gross total'
    field :total_discount, Float, null: false, description: 'Total discount'
    field :total_tax, Float, null: false, description: 'Total tax'
    field :total, Float, null: false, description: 'Total cart'
  end
end