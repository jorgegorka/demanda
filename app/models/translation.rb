class Translation < ApplicationRecord
  belongs_to :translatable, polymorphic: true

  validates :language, presence: true
end
