class Comment < ApplicationRecord
  include ActionView::Helpers::SanitizeHelper
  include Uuidable

  before_save :sanitize_description
  before_save :update_replied_at
  before_validation :add_default_language
  after_save :update_product_rating
  after_destroy :update_product_rating

  belongs_to :commentable, polymorphic: true
  belongs_to :account
  belongs_to :user
  belongs_to :language

  validates :description, presence: true, length: { maximum: 800 }
  validates :reply_description, length: { maximum: 1200 }
  validates :rating, inclusion: { in: 0..5 }, allow_nil: true

  scope :approved, -> { where(approved: true) }
  scope :pending, -> { where(approved: false) }
  scope :with_rating, -> { where('rating > 0') }

  def for_id
    commentable.uuid
  end

  def for_type
    commentable.class.to_s
  end

  def for_name
    commentable.name
  end

  private

  def sanitize_description
    self.description = strip_tags(description)
    self.reply_description = strip_tags(reply_description)
  end

  def update_replied_at
    self.replied_at = Time.current if reply_description_changed?
  end

  def add_default_language
    return if language_id.present?

    self.language_id = user&.language&.id || account&.default_language_id
  end

  def update_product_rating
    return unless comment_approved_for_product

    Products::Rating.new(commentable).update
  end

  def comment_approved_for_product
    for_type == 'Product' && approved?
  end
end
