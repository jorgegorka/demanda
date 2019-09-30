class Provider < ApplicationRecord
  include Uuidable
  include Directionable

  belongs_to :account

  validates :account_id, presence: true
  validates :name, presence: true
end
