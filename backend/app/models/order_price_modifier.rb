class OrderPriceModifier < ApplicationRecord
  include Uuidable

  belongs_to :order, optional: true
  belongs_to :order_item, optional: true
  belongs_to :product, optional: true
  belongs_to :category, optional: true
  belongs_to :customer, optional: true
  belongs_to :price_modifier

  monetize :amount_cents
  monetize :percentage_cents, with_currency: :num
  monetize :minimum_quantity_cents, with_currency: :num
  monetize :minimum_price_cents, with_currency: :num

  def update_price
    Price::Calculator.new(self).update_price
  end
end
