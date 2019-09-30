class Product < ApplicationRecord
  include Uuidable
  include Localisable

  belongs_to :account
  belongs_to :category

  validates :account_id, presence: true
  validates :name, presence: true
end
