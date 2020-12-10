# frozen_string_literal: true

module Types
  class Account < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :name, String, null: false
    field :addresses, [Types::Address], null: true
  end
end
