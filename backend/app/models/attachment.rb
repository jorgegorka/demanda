class Attachment < ApplicationRecord
  include Uuidable

  belongs_to :attachable, polymorphic: true

  validates :title, presence: true
end
