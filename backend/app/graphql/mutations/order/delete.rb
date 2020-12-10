# frozen_string_literal: true

module Mutations
  module Order
    class Delete < Mutations::ManagerMutation
      graphql_name 'DeleteOrder'

      argument :id, String, required: true

      field :errors, [String], null: true
      field :order, Types::Order, null: true

      def resolve(id:)
        order = Orders::Persistence.new(current_account).destroy(id)

        {
          errors: order.errors.full_messages,
          order: order
        }
      end
    end
  end
end
