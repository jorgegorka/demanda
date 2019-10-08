module Mutations
  module Discount
    class Delete < Mutations::AuthorisedMutation
      graphql_name 'DeleteDiscount'

      argument :id, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(id:)
        authorise_user
        discount = current_account.discounts.find_by(uuid: id)

        discount.destroy
        {
          errors: [],
          message: 'Discount was deleted'
        }
      end
    end
  end
end
