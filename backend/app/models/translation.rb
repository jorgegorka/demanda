class Translation < ApplicationRecord
  include Uuidable

  belongs_to :translatable, polymorphic: true
  belongs_to :language

  validates :name, presence: true

  scope :with_meta_title, -> { where(name: 'meta-title') }
  scope :with_meta_description, -> { where(name: 'meta-description') }
end
