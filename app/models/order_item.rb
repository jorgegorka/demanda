class OrderItem < ApplicationRecord
  include Uuidable

  belongs_to :order
  belongs_to :product

  has_many :order_price_modifiers, dependent: :destroy

  after_create :add_modifiers

  protected

  def add_modifiers
    Orderitems::PriceModifiers.new(self).add
  end
end
