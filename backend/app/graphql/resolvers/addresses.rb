# frozen_string_literal: true

module Resolvers
  class Addresses < Resolvers::Base
    type '[Types::Address]', null: true

    description 'Find all addresses or filter by id'
    argument :id, String, required: false, default_value: '', as: :uuid

    def resolve(uuid:)
      return unless current_user

      @db_query = current_user.addresses
      filter_uuid(uuid)

      db_query.order(:name)
    end
  end
end
