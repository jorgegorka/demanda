# frozen_string_literal: true

class Attachment < ApplicationRecord
  include Uuidable

  belongs_to :attachable, polymorphic: true
  belongs_to :language, optional: true
  has_one_attached :media_item

  validates :title, presence: true

  def url
    return '' unless media_item.attached?

    Rails.application.routes.url_helpers.rails_blob_url(media_item, host: attachable.account.domain)
  end

  def content_type
    return '' unless media_item.attached?

    media_item.blob.content_type
  end
end
