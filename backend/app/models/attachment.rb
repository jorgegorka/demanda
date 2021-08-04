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

  def thumb
    create_variant_url([100, nil])
  end

  def mini
    create_variant_url([300, nil])
  end

  def standard
    create_variant_url([600, nil])
  end

  def big
    create_variant_url([1400, nil])
  end

  def content_type
    return '' unless media_item.attached?

    media_item.blob.content_type
  end

  private

  def create_variant_url(size)
    variant = media_item.variant(resize_to_limit: size)
    Rails.application.routes.url_helpers.rails_representation_url(variant, host: attachable.account.domain)
  end

end
