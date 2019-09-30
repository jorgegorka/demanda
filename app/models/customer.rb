class Customer < ApplicationRecord
  include Uuidable

  belongs_to :account

  has_many :orders, dependent: :destroy

  validates :account_id, presence: true
  validates :name, presence: true
end
