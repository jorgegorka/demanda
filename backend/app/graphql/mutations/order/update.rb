# frozen_string_literal: true

module Mutations
  module Order
    class Update < Mutations::ManagerMutation
      graphql_name 'UpdateOrder'

      argument :id, String, required: true
      argument :status, Types::OrderStatusEnum, required: true

      field :errors, [String], null: true
      field :order, Types::Order, null: true

      def resolve(params)
        order = Orders::Persistence.new(current_account).update(params)

        {
          errors: order.errors.full_messages,
          order: order
        }
      end
    end
  end
end
