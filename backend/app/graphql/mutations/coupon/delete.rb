# frozen_string_literal: true

module Mutations
  module Coupon
    class Delete < Mutations::ManagerMutation
      graphql_name 'DeleteCoupon'

      argument :id, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(id:)
        coupon = current_account.coupons.find_by(uuid: id)

        if coupon
          coupon.destroy
          {
            errors: coupon.errors.full_messages,
            message: 'Coupon was deleted'
          }
        else
          {
            errors: ["id: #{id}", 'Coupon not found'],
            message: ''
          }
        end
      end
    end
  end
end
