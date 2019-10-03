module Mutations
  module Tax
    class Delete < Mutations::AuthorisedMutation
      graphql_name 'DeleteTax'

      argument :uuid, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(uuid:)
        authorise_user
        tax = current_account.taxes.find_by(uuid: uuid)

        tax.destroy
        {
          errors: [],
          message: 'Tax was deleted'
        }
      end
    end
  end
end
