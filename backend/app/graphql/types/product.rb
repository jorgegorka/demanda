# frozen_string_literal: true

module Types
  class Product < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :name, String, null: false
    field :slug, String, null: false
    field :category_id, String, null: true, method: :category_uuid
    field :category, Types::Category, null: true
    field :price, Float, null: false, description: 'Price'
    field :stock, Integer, null: false
    field :meta_title, String, null: true
    field :meta_description, String, null: true
    field :tags, String, null: true, method: :tags_for_query
    field :translations, [Types::Translation], null: true
    field :attachments, [Types::Attachment], null: true
    field :related, [Types::Product], null: true
    field :comments, [Types::Comment], null: true
    field :main_image_url, String, null: true, method: :main_image
    field :main_image_thumb_url, String, null: true, method: :main_image_thumb
  end
end
