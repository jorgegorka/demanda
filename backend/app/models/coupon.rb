class Coupon < PriceModifier
  has_many :orders

  validates :code, presence: true, uniqueness: { scope: :account_id, case_sensitive: false }
  validates :name, presence: true

  after_initialize :assign_coupon_code, if: :new_record?

  def tax?
    false
  end

  protected

  def assign_coupon_code
    self.code = SecureRandom.hex(8)
  end
end
