# frozen_string_literal: true

module Mutations
  module Coupon
    class Create < Mutations::ManagerMutation
      graphql_name 'CreateCoupon'

      argument :name, String, required: true
      argument :code, String, required: false
      argument :product_id, String, required: false
      argument :category_id, String, required: false
      argument :user_id, String, required: false
      argument :active, Boolean, required: false
      argument :single_use, Boolean, required: false
      argument :percentage, Float, required: true
      argument :amount, Integer, required: true
      argument :start_at, GraphQL::Types::ISO8601DateTime, required: true
      argument :end_at, GraphQL::Types::ISO8601DateTime, required: false
      argument :minimum_quantity, Float, required: false
      argument :minimum_price, Float, required: false

      field :errors, [String], null: true
      field :coupon, Types::Coupon, null: true

      def resolve(params)
        coupon = Coupons::Persistence.new(current_account).create(params)
        {
          errors: coupon.errors.full_messages,
          coupon: coupon
        }
      end
    end
  end
end
