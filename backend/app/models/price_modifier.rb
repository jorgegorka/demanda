class PriceModifier < ApplicationRecord
  include Uuidable
  include Localisable

  belongs_to :account
  belongs_to :product, optional: true
  belongs_to :category, optional: true
  belongs_to :user, optional: true

  validates :name, presence: true
  validates :active, inclusion: { in: [true, false] }
  validates :start_at, presence: true
  validate :amount_or_percentge_are_present

  monetize :amount_cents
  monetize :percentage_cents, with_currency: :num
  monetize :minimum_quantity_cents, with_currency: :num
  monetize :minimum_price_cents, with_currency: :num

  after_initialize :assign_start_at, if: :new_record?

  scope :active, -> { where(active: true).where('(:created_at BETWEEN START_AT AND END_AT) OR (END_AT IS NULL AND :created_at >= START_AT)', { created_at: Date.current }) }
  scope :global, -> { where(product_id: nil, category_id: nil) }

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
