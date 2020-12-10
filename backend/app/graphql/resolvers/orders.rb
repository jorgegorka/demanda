# frozen_string_literal: true

module Resolvers
  class Orders < Resolvers::Base
    type '[Types::Order]', null: true

    description 'Find all orders or filter by status'
    argument :id, String, required: false, default_value: '', as: :uuid
    argument :status, String, required: false, default_value: ''

    def resolve(uuid:, status:)
      @db_query = current_user.orders
      filter_uuid(uuid)
      filter_status(status)

      db_query.order(:status, :created_at)
    end

    private

    def filter_status(status)
      @db_query = db_query.where(status: status)
    end
  end
end
