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

  after_create :add_modifiers

  def gross_price
    total_gross_price = 0
    order_items.each do |order_item|
      total_gross_price += (order_item.quantity.amount * order_item.price.amount * 100)
    end
    Money.new(total_gross_price, 'EU2')
  end

  def update_price
    order_price_modifiers.each { |price_modifier| Price::Calculator.new(price_modifier).update_price }
    save
  end

  protected

  def add_modifiers
    Orders::PriceModifiers.new(self).add
  end
end
