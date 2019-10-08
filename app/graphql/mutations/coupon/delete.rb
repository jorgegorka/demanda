module Mutations
  module Coupon
    class Delete < Mutations::AuthorisedMutation
      graphql_name 'DeleteCoupon'

      argument :id, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(id:)
        authorise_user
        coupon = current_account.coupons.find_by(uuid: id)

        coupon.destroy
        {
          errors: [],
          message: 'Coupon was deleted'
        }
      end
    end
  end
end
