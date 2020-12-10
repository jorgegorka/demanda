# frozen_string_literal: true

module Types
  class Country < Types::BaseObject
    field :id, String, null: false
    field :continent, String, null: false
    field :region, String, null: false
    field :subregion, String, null: false
    field :world_region, String, null: false
    field :name, String, null: false
    field :eu_member, Boolean, null: false
    field :translations, String, null: false
  end
end
