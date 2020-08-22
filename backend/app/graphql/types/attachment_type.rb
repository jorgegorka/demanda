# frozen_string_literal: true

module Types
  class AttachmentType < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :title, String, null: false
    field :order, Integer, null: false
  end
end
