class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :address_1, presence: true
  validates :city, presence: true
end
