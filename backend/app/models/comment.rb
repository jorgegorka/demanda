# frozen_string_literal: true

class Comment < ApplicationRecord
  include ActionView::Helpers::SanitizeHelper
  include Uuidable

  before_save :sanitize_description

  belongs_to :commentable, polymorphic: true
  belongs_to :user
  belongs_to :language

  validates :description, presence: true, length: { maximum: 800 }
  validates :rating, inclusion: { in: 0..5 }, allow_nil: true

  scope :approved, -> { where(approved: true) }
  scope :pending, -> { where(approved: false) }

  private

  def sanitize_description
    self.description = strip_tags(description)
  end
end
