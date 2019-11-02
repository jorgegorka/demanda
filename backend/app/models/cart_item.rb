class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  monetize :quantity_cents, with_currency: :num
  monetize :price_cents
  monetize :total_tax_cents
  monetize :total_discount_cents
  monetize :total_cents

  def gross_price
    Money.new(quantity * price, 'EU2')
  end

  def total_discount
    0
  end

  def total_tax
    0
  end

  def net_price
    Money.new(gross_price - total_discount, 'EU2')
  end

  protected

  def price_modifiers
    PriceModifiers::Finder.for_product(self, self.cart)
  end
end