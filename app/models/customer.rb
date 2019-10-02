class Customer < ApplicationRecord
  include Uuidable
  include Directionable

  belongs_to :account

  has_many :orders, dependent: :destroy

  validates :name, presence: true
end
