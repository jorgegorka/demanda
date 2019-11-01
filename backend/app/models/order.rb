class Order < ApplicationRecord
  include Uuidable
  include Directionable

  belongs_to :account
  belongs_to :customer
  belongs_to :coupon, optional: true

  has_many :order_items, dependent: :destroy
  has_many :order_price_modifiers, dependent: :destroy

  enum status: %i[card confirmed delivered received rejected cancelled]

  monetize :total_tax_cents
  monetize :total_discount_cents

  def gross_price
    total_items = order_items.inject(0) { |total, order_item| total + order_item.net_price }
    Money.new(total_items, 'EU2')
  end

  def net_price
    Money.new(gross_price + total_tax - total_discount, 'EU2')
  end

  def add_modifiers
    Orders::PriceModifiers.new(self).add
    update_price
  end

  protected

  def update_price
    order_price_modifiers.each { |price_modifier| Price::Calculator.new(price_modifier).update_price }
    save
  end
end
