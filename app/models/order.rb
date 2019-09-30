class Order < ApplicationRecord
  include Uuidable

  belongs_to :account
  belongs_to :customer
  belongs_to :coupon, optional: true

  has_many :order_items, dependent: :destroy
  has_many :order_price_modifiers, dependent: :destroy

  enum status: %i[card confirmed delivered received rejected cancelled]

  after_create :add_modifiers

  protected

  def add_modifiers
    Orders::PriceModifiers.new(self).add
  end
end
