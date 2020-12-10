# frozen_string_literal: true

module Resolvers
  class Languages < Resolvers::Base
    type [Types::Language], null: true

    description 'Find all languages or filter by name'
    argument :id, String, required: false, default_value: '', as: :uuid
    argument :name, String, required: false, default_value: ''

    def resolve(uuid:, name:)
      @db_query = current_account.languages
      filter_name(name)
      filter_uuid(uuid)

      db_query.order(:name)
    end
  end
end
