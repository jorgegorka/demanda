# frozen_string_literal: true

class Product < ApplicationRecord
  include Uuidable
  include Localisable
  include Attachable
  include Commentable
  include Slugable
  include MetaTaggable

  Gutentag::ActiveRecord.call self

  belongs_to :account
  belongs_to :category, optional: true

  validates :name, presence: true
  validates :slug, uniqueness: { scope: :account_id, case_sensitive: false }

  monetize :price_cents

  delegate :uuid, to: :category, prefix: true, allow_nil: true

  after_create :add_default_content

  def tags_for_query
    tag_names.join(', ')
  end

  def related
    if related_products.blank?
      Product.where.not(id: id).order('RAND()').limit(3)
    else
      Product.where(id: related_products.split(',')).order(:name)
    end
  end

  def main_image
    attachments.order(order: :asc).first&.url
  end

  def main_image_thumb
    attachments.order(order: :asc).first&.thumb
  end

  private

  def add_default_content
    Translations::Create.content_for_product(self)
  end
end
