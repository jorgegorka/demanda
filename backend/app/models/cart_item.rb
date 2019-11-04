class CartItem < ApplicationRecord
  include TotalUpdatable

  belongs_to :cart
  belongs_to :product

  delegate :price, to: :product

  monetize :quantity_cents, with_currency: :num
  monetize :total_tax_cents
  monetize :total_discount_cents

  def gross_price
    Money.new(quantity.amount * price.amount * 100, 'EU2')
  end

  def net_price
    Money.new(gross_price - total_discount, 'EU2')
  end

  def total
    Money.new(net_price + total_tax, 'EU2')
  end

  protected

  def price_modifiers
    PriceModifiers::Finder.for_product(self, self.cart)
  end
end