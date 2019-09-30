class User < ApplicationRecord
  include Uuidable
  include Directionable
  belongs_to :account

  enum role: %i[customer admin manager]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :token_authenticatable

  validates :email, presence: true
  validates :email, length: { maximum: 255 }
  validates :email, format: { with: VALID_EMAIL_REGEX }
  validates :first_name, presence: true
  validates :first_name, length: { maximum: 255 }
  validates :last_name, presence: true
  validates :last_name, length: { maximum: 255 }
  validates :role, presence: true
  validates :account_id, presence: true, unless: Proc.new { |user| user.admin? }

  after_initialize :setup_new_user, if: :new_record?

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def name
    [first_name, last_name].join(' ').strip
  end

  def isManager?
    admin? || manager?
  end

  private

  def setup_new_user
    self.role ||= :customer
  end
end
