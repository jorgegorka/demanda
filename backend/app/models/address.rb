class Address < ApplicationRecord
  include Uuidable

  belongs_to :addressable, polymorphic: true

  validates :first_address, presence: true
  validates :city, presence: true
end
