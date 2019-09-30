class OrderPriceModifier < ApplicationRecord
  include Uuidable

  belongs_to :order, optional: true
  belongs_to :order_item, optional: true
  belongs_to :product, optional: true
  belongs_to :category, optional: true
  belongs_to :customer, optional: true
  belongs_to :price_modifier

  validates :price_modifier_id, presence: true
end
