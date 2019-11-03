class Order < ApplicationRecord
  include Uuidable
  include Directionable
  include TotalUpdatable

  belongs_to :account
  belongs_to :customer
  belongs_to :coupon, optional: true

  has_many :order_items, dependent: :destroy
  has_many :order_price_modifiers, dependent: :destroy

  enum status: %i[confirmed delivered received rejected cancelled]

  monetize :total_tax_cents
  monetize :total_discount_cents

  def gross_price
    total_items = order_items.inject(0) { |total, order_item| total + order_item.total.amount }
    Money.new(total_items * 100, 'EU2')
  end

  def net_price
    Money.new((gross_price.amount - total_discount.amount) * 100, 'EU2')
  end

  def total
    Money.new((net_price.amount + total_tax.amount) * 100, 'EU2')
  end

  def add_modifiers
    Orders::PriceModifiers.new(self).add
    update_total
  end

  protected

  def price_modifiers
    order_price_modifiers
  end
end
