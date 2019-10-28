class Account < ApplicationRecord
  include Uuidable
  include Directionable

  has_many :users, dependent: :destroy
  has_many :providers, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :price_modifiers, dependent: :destroy
  has_many :taxes, dependent: :destroy
  has_many :customers, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :discounts, dependent: :destroy
  has_many :coupons, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :languages, dependent: :destroy

  has_one :admin, -> { where(role: :admin) }, class_name: 'User'

  validates :name, presence: true
  validates_associated :users
end
