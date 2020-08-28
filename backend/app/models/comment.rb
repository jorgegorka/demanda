# frozen_string_literal: true

class Comment < ApplicationRecord
  include ActionView::Helpers::SanitizeHelper
  include Uuidable

  before_save :sanitize_description
  before_save :update_replied_at

  belongs_to :commentable, polymorphic: true
  belongs_to :account
  belongs_to :user
  belongs_to :language

  validates :description, presence: true, length: { maximum: 800 }
  validates :reply_description, length: { maximum: 1200 }
  validates :rating, inclusion: { in: 0..5 }, allow_nil: true

  scope :approved, -> { where(approved: true) }
  scope :pending, -> { where(approved: false) }

  private

  def sanitize_description
    self.description = strip_tags(description)
    self.reply_description = strip_tags(reply_description)
  end

  def update_replied_at
    self.replied_at = Time.current if reply_description_changed?
  end
end
