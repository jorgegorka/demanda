class Translation < ApplicationRecord
  include Uuidable

  belongs_to :translatable, polymorphic: true
  belongs_to :language

  validates :name, presence: true
end
