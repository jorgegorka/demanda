class Category < ApplicationRecord
  include Uuidable
  include Localisable

  acts_as_tree order: "name"

  belongs_to :account

  validates :account_id, presence: true
  validates :name, presence: true
end
