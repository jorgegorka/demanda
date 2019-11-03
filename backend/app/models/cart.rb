class Cart < ApplicationRecord
  include Uuidable
  include TotalUpdatable

  belongs_to :account
  belongs_to :customer, optional: true

  has_many :cart_items, dependent: :destroy

  monetize :total_tax_cents
  monetize :total_discount_cents

  def gross_price
    total_items = cart_items.inject(0) { |total, cart_item| total + cart_item.total.amount }
    Money.new(total_items * 100, 'EU2')
  end

  def net_price
    Money.new((gross_price.amount - total_discount.amount) * 100, 'EU2')
  end

  def total
    Money.new((net_price.amount + total_tax.amount) * 100, 'EU2')
  end

  def recalculate
    cart_items.each(&:update_total)
    update_total
  end

  protected

  def price_modifiers
    PriceModifiers::Finder.global(self)
  end
end
