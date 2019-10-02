class Translation < ApplicationRecord
  include Uuidable

  belongs_to :translatable, polymorphic: true

  validates :language, presence: true
end
