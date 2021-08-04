class Cart < ApplicationRecord
  include Uuidable
  include TotalUpdatable

  belongs_to :account
  belongs_to :user, optional: true

  has_many :cart_items, dependent: :destroy

  monetize :total_tax_cents
  monetize :total_discount_cents

  def total_gross
    total_items = cart_items.inject(0) { |total, cart_item| total + cart_item.total.amount }
    Money.new(total_items * 100, 'EU2')
  end

  def total_net
    Money.new((total_gross.amount - total_discount.amount) * 100, 'EU2')
  end

  def total
    Money.new((total_net.amount + total_tax.amount) * 100, 'EU2')
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
