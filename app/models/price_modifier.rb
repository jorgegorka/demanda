class PriceModifier < ApplicationRecord
  include Uuidable
  include Localisable

  belongs_to :account
  belongs_to :product, optional: true
  belongs_to :category, optional: true
  belongs_to :customer, optional: true

  validates :name, presence: true
  validates :active, presence: true
  validates :start_at, presence: true
  validate :amount_or_percentge_are_present
  after_initialize :assign_start_at, if: :new_record?

  monetize :amount_cents
  monetize :percentage_cents, with_currency: :num
  monetize :minimum_quantity_cents, with_currency: :num
  monetize :minimum_price_cents, with_currency: :num

  scope :active, -> { where(active: true) }
  scope :for_orders, -> { where(product_id: nil, category_id: nil) }
  scope :for_products, -> { where('PRODUCT_ID IS NOT NULL OR CATEGORY_ID IS NOT NULL') }

  protected

  def amount_or_percentge_are_present
    errors.add(:base, 'Please add an amount or a percentage.') if no_price?
    errors.add(:base, "You can't have both an amount and a percentage. Please choose one.") if both_prices?
  end

  def present_and_not_zero?(value)
    value.present? && !value.zero?
  end

  def no_price?
    !present_and_not_zero?(amount) && !present_and_not_zero?(percentage)
  end

  def both_prices?
    present_and_not_zero?(amount) && present_and_not_zero?(percentage)
  end

  def assign_start_at
    self.start_at = DateTime.current
  end
end
