# frozen_string_literal: true

module Types
  class CommentType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :description, String, null: false
    field :rating, Float, null: true
    field :summary, String, null: true
    field :featured, Boolean, null: true
    field :verified_purchase, Boolean, null: true
    field :approved, Boolean, null: true
    field :reply_description, String, null: true
    field :replied_at, GraphQL::Types::ISO8601DateTime, null: true
    field :language, Types::LanguageType, null: true
    field :user, Types::UserType, null: true
  end
end
