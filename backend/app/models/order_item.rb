class OrderItem < ApplicationRecord
  include Uuidable
  include TotalUpdatable

  belongs_to :order
  belongs_to :product

  has_many :order_price_modifiers, dependent: :destroy

  monetize :price_cents
  monetize :quantity_cents, with_currency: :num
  monetize :total_tax_cents
  monetize :total_discount_cents

  after_create :add_modifiers

  def total_gross
    Money.new(quantity.amount * price.amount * 100, 'EU2')
  end

  def total_net
    Money.new(total_gross - total_discount, 'EU2')
  end

  def total
    Money.new(total_net + total_tax, 'EU2')
  end

  protected

  def add_modifiers
    OrderItems::PriceModifiers.new(self).add
    update_total
  end

  def price_modifiers
    order_price_modifiers
  end
end
