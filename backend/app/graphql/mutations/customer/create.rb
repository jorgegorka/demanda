module Mutations
  module Customer
    class Create < Mutations::BaseMutation
      graphql_name 'CreateCustomer'

      argument :name, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true
      argument :language_id, String, required: false

      field :errors, [String], null: true
      field :customer, Types::CustomerType, null: true

      def resolve(params)
        customer = Customers::Persistence.new(current_account, current_user).create(params)
        {
          errors: customer.errors.full_messages,
          customer: customer
        }
      end
    end
  end
end
