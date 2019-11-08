# frozen_string_literal: true

module Resolvers
  class CurrentUser < Resolvers::Base
    type Types::CustomerType, null: true

    description 'Find all carts or filter by id'
    argument :id, String, required: false, default_value: '', as: :uuid

    def resolve(uuid:)
      @db_query = current_account.carts
      filter_uuid(uuid)

      db_query
    end
  end
end
