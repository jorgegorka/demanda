# frozen_string_literal: true

module Types
  class ProductType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :name, String, null: false
    field :slug, String, null: false
    field :category_id, String, null: true, method: :category_uuid
    field :category, Types::CategoryType, null: true
    field :price, Float, null: false, description: 'Price'
    field :stock, Integer, null: false
    field :tags, String, null: true, method: :tags_for_query
    field :translations, [Types::TranslationType], null: true
    field :attachments, [Types::AttachmentType], null: true
    field :related, [Types::ProductType], null: true
  end
end
