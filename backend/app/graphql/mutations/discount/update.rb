# frozen_string_literal: true

module Mutations
  module Discount
    class Update < Mutations::ManagerMutation
      graphql_name 'UpdateDiscount'

      argument :id, String, required: true
      argument :name, String, required: false
      argument :product_id, String, required: false
      argument :category_id, String, required: false
      argument :user_id, String, required: false
      argument :active, Boolean, required: false
      argument :percentage, Float, required: false
      argument :amount, Integer, required: false
      argument :start_at, GraphQL::Types::ISO8601DateTime, required: false
      argument :end_at, GraphQL::Types::ISO8601DateTime, required: false
      argument :minimum_quantity, Float, required: false
      argument :minimum_price, Float, required: false

      field :errors, [String], null: true
      field :discount, Types::DiscountType, null: true

      def resolve(params)
        authorise_user

        discount = Discounts::Persistence.new(current_account).update(params)
        {
          errors: discount.errors.full_messages,
          discount: discount
        }
      end
    end
  end
end
