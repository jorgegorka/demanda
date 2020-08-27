# frozen_string_literal: true

module Mutations
  module Customer
    class Update < Mutations::ManagerMutation
      graphql_name 'UpdateCustomer'

      argument :id, String, required: true
      argument :name, String, required: true

      field :errors, [String], null: true
      field :customer, Types::CustomerType, null: true

      def resolve(id:, name:)
        customer = current_account.customers.find_by(uuid: id)
        customer.update_attribute(:name, name)
        {
          errors: customer.errors.full_messages,
          customer: customer
        }
      end
    end
  end
end
