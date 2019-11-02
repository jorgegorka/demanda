class Cart < ApplicationRecord
  include Uuidable

  belongs_to :account
  belongs_to :customer, optional: true

  has_many :cart_items, dependent: :destroy

  monetize :total_tax_cents
  monetize :total_discount_cents
  monetize :total_cents
  monetize :total_gross_cents
end
