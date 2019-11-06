class Customer < ApplicationRecord
  include Uuidable
  include Directionable

  before_destroy :check_empty_orders

  belongs_to :account
  belongs_to :language
  has_one :cart
  has_one :user
  has_many :orders

  validates :name, presence: true

  protected

  def check_empty_orders
    if orders.any?
      errors.add(:base, 'Customer should have no orders associated')
      throw :abort
    end
  end
end
