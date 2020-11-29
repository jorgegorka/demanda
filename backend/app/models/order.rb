class Order < ApplicationRecord
  include Uuidable
  include Directionable
  include TotalUpdatable

  belongs_to :account
  belongs_to :user
  belongs_to :coupon, optional: true

  has_many :order_items, dependent: :destroy
  has_many :order_price_modifiers, dependent: :destroy

  enum status: { received: 0, approved: 1, on_route: 2, delivered: 3, rejected: 4, cancelled: 5 }

  monetize :total_tax_cents
  monetize :total_discount_cents

  def total_gross
    total_items = order_items.inject(0) { |total, order_item| total + order_item.total.amount }
    Money.new(total_items * 100, 'EU2')
  end

  def total_net
    Money.new((total_gross.amount - total_discount.amount) * 100, 'EU2')
  end

  def total
    Money.new((total_net.amount + total_tax.amount) * 100, 'EU2')
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
