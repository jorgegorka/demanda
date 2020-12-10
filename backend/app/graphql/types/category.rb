# frozen_string_literal: true

module Types
  class Category < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :name, String, null: false
    field :slug, String, null: false
    field :parent, Types::Category, null: true
    field :children, [Types::Category], null: true
    field :children_count, Integer, null: true
    field :products, [Types::Product], null: true
    field :translations, [Types::Translation], null: true
    field :attachments, [Types::Attachment], null: true
  end
end
