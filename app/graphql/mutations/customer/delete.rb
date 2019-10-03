module Mutations
  module Customer
    class Delete < Mutations::AuthorisedMutation
      graphql_name 'DeleteCustomer'

      argument :uuid, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(uuid:)
        authorise_user
        customer = current_account.customers.find_by(uuid: uuid)

        if customer.orders.count.zero?
          customer.destroy
          {
            errors: [],
            message: 'Customer was deleted'
          }
        else
          {
            errors: ['Customer should have no orders associated.'],
            message: "Can't delete."
          }
        end
      end
    end
  end
end
