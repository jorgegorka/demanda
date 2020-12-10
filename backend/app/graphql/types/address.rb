# frozen_string_literal: true

module Types
  class Address < Types::BaseObject
    field :id, String, null: false, method: :uuid
    field :name, String, null: true
    field :first_address, String, null: false
    field :second_address, String, null: true
    field :postal_code, String, null: false
    field :city, String, null: false
    field :country, String, null: false
  end
end
