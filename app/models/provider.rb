class Provider < ApplicationRecord
  include Uuidable
  include Directionable

  belongs_to :account

  validates :name, presence: true
end
