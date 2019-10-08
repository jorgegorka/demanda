module Mutations
  module Customer
    class Delete < Mutations::AuthorisedMutation
      graphql_name 'DeleteCustomer'

      argument :id, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(id:)
        authorise_user
        customer = current_account.customers.find_by(uuid: id)

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
