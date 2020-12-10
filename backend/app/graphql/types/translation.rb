# frozen_string_literal: true

module Types
  class Translation < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :name, String, null: false
    field :description, String, null: true
    field :language, Types::Language, null: true
  end
end
