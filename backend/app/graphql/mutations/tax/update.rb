# frozen_string_literal: true

module Mutations
  module Tax
    class Update < Mutations::ManagerMutation
      graphql_name 'UpdateTax'

      argument :id, String, required: true
      argument :name, String, required: true
      argument :product_id, String, required: false
      argument :category_id, String, required: false
      argument :customer_id, String, required: false
      argument :active, Boolean, required: false
      argument :percentage, Float, required: false
      argument :amount, Integer, required: false
      argument :start_at, GraphQL::Types::ISO8601DateTime, required: false
      argument :end_at, GraphQL::Types::ISO8601DateTime, required: false
      argument :minimum_quantity, Float, required: false
      argument :minimum_price, Float, required: false

      field :errors, [String], null: true
      field :tax, Types::TaxType, null: true

      def resolve(params)
        authorise_user

        tax = Taxes::Persistence.new(current_account).update(params)
        {
          errors: tax.errors.full_messages,
          tax: tax
        }
      end
    end
  end
end
