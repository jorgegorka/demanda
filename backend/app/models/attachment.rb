# frozen_string_literal: true

class Attachment < ApplicationRecord
  include Uuidable

  belongs_to :attachable, polymorphic: true
  belongs_to :language, optional: true
  has_one_attached :media_item

  validates :title, presence: true
end
