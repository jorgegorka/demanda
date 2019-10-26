class Product < ApplicationRecord
  include Uuidable
  include Localisable

  belongs_to :account
  belongs_to :category, optional: true

  validates :name, presence: true

  monetize :price_cents

  def category_uuid
    category.uuid
  end
end
