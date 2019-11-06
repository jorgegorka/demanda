class User < ApplicationRecord
  include Uuidable
  include Directionable
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  authenticates_with_sorcery!

  belongs_to :account
  belongs_to :customer

  enum role: %i[customer admin manager]

  validates :password, length: { minimum: 8 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :email, presence: true
  validates :email, length: { maximum: 255 }
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :role, presence: true
  validates :account_id, presence: true, unless: Proc.new { |user| user.admin? }

  after_initialize :setup_new_user, if: :new_record?

  def isManager?
    admin? || manager?
  end

  private

  def setup_new_user
    self.role ||= :customer
  end
end
