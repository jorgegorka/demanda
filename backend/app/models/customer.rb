class Customer < ApplicationRecord
  include Uuidable
  include Directionable

  belongs_to :account

  has_many :orders

  validates :name, presence: true

  before_destroy :check_empty_orders

  protected

  def check_empty_orders
    if orders.any?
      errors.add(:base, 'Customer should have no orders associated')
      throw :abort
    end
  end
end
