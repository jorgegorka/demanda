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

  def update_price
    order_price_modifiers.each { |price_modifier| Price::Calculator.new(price_modifier).update_price }
    save
  end

  protected

  def add_modifiers
    OrderItems::PriceModifiers.new(self).add
  end
end
