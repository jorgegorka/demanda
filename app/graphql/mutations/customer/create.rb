module Mutations
  module Customer
    class Create < Mutations::AuthorisedMutation
      graphql_name 'CreateCustomer'

      argument :name, String, required: true

      field :errors, [String], null: true
      field :customer, Types::CustomerType, null: true

      def resolve(name:)
        authorise_user
        customer = current_account.customers.create(name: name)
        {
          errors: customer.errors.full_messages,
          customer: customer
        }
      end
    end
  end
end
