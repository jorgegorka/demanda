class Order < ApplicationRecord
  include Uuidable
  include Directionable

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

  def update_total
    order_price_modifiers.each do |order_price_modifier|
      price_calculator = Price::Calculator.new(order_price_modifier, net_price.amount)
      price_calculator.calculate
      self.total_tax = total_tax.amount + price_calculator.total_tax.amount
      self.total_discount = total_discount.amount + price_calculator.total_discount.amount
    end

    save
  end
end
