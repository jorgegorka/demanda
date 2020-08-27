# frozen_string_literal: true

module Mutations
  module Discount
    class Create < Mutations::ManagerMutation
      graphql_name 'CreateDiscount'

      argument :name, String, required: true
      argument :product_id, String, required: false
      argument :category_id, String, required: false
      argument :customer_id, String, required: false
      argument :active, Boolean, required: false
      argument :percentage, Float, required: true
      argument :amount, Integer, required: true
      argument :start_at, GraphQL::Types::ISO8601DateTime, required: true
      argument :end_at, GraphQL::Types::ISO8601DateTime, required: false
      argument :minimum_quantity, Float, required: false
      argument :minimum_price, Float, required: false

      field :errors, [String], null: true
      field :discount, Types::DiscountType, null: true

      def resolve(params)
        authorise_user

        discount = Discounts::Persistence.new(current_account).create(params)
        {
          errors: discount.errors.full_messages,
          discount: discount
        }
      end
    end
  end
end
