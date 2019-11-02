class OrderItem < ApplicationRecord
  include Uuidable

  belongs_to :order
  belongs_to :product

  has_many :order_price_modifiers, dependent: :destroy

  monetize :price_cents
  monetize :quantity_cents, with_currency: :num
  monetize :total_tax_cents
  monetize :total_discount_cents

  after_create :add_modifiers

  def gross_price
    Money.new(quantity.amount * price.amount * 100, 'EU2')
  end

  def net_price
    Money.new(gross_price - total_discount, 'EU2')
  end

  def total
    Money.new(net_price + total_tax, 'EU2')
  end

  def update_price
    order_price_modifiers.each do |order_price_modifier|
      price_calculator = Price::Calculator.new(order_price_modifier, net_price)
      price_calculator.calculate
      self.total_discount = total_discount.amount + price_calculator.total_discount.amount
      self.total_tax = total_tax.amount + price_calculator.total_tax.amount
    end

    save
  end

  protected

  def add_modifiers
    OrderItems::PriceModifiers.new(self).add
    update_price
  end
end
