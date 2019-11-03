class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  monetize :quantity_cents, with_currency: :num
  monetize :price_cents
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

  def update_total
    price_modifiers.each do |price_modifier|
      price_calculator = Price::Calculator.new(price_modifier, net_price.amount)
      price_calculator.calculate
      self.total_discount = price_calculator.total_discount.amount
      self.total_tax = price_calculator.total_tax.amount
    end

    save
  end

  protected

  def price_modifiers
    PriceModifiers::Finder.for_product(self, self.cart)
  end
end