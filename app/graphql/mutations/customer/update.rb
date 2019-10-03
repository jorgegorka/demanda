module Mutations
  module Customer
    class Update < Mutations::AuthorisedMutation
      graphql_name 'UpdateCustomer'

      argument :uuid, String, required: true
      argument :name, String, required: true

      field :errors, [String], null: true
      field :customer, Types::CustomerType, null: true

      def resolve(uuid:, name:)
        authorise_user
        customer = current_account.customers.find_by(uuid: uuid)
        customer.update_attribute(:name, name)
        {
          errors: customer.errors.full_messages,
          customer: customer
        }
      end
    end
  end
end
