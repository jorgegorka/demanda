# frozen_string_literal: true

module Types
  class CategoryType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :name, String, null: false
    field :slug, String, null: false
    field :summary, String, null: true
    field :description, String, null: true
    field :meta_title, String, null: true
    field :meta_description, String, null: true
    field :parent, Types::CategoryType, null: true
    field :children, [Types::CategoryType], null: true
    field :children_count, Integer, null: true
    field :products, [Types::ProductType], null: true
    field :translations, [Types::TranslationType], null: true
    field :attachments, [Types::AttachmentType], null: true
  end
end
