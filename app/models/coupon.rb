# frozen_string_literal: true

class Coupon < PriceModifier
  validates :code, presence: true
  validates :name, presence: true

  after_initialize :assign_coupon_code, if: :new_record?

  protected

  def assign_coupon_code
    self.code = SecureRandom.hex(16)
  end
end
