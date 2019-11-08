module Mutations
  module Customer
    class Delete < Mutations::AuthorisedMutation
      graphql_name 'DeleteCustomer'

      argument :id, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(id:)
        customer = current_account.customers.find_by(uuid: id)

        if customer
          customer.destroy
          {
            errors: customer.errors.full_messages,
            message: customer.destroyed?
          }
        else
          {
            errors: ["id: #{id}", 'Customer not found'],
            message: ''
          }
        end
      end
    end
  end
end
