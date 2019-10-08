module Mutations
  module Tax
    class Delete < Mutations::AuthorisedMutation
      graphql_name 'DeleteTax'

      argument :id, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(id:)
        authorise_user
        tax = current_account.taxes.find_by(uuid: id)

        if tax
          tax.destroy
          {
            errors: tax.errors.full_messages,
            message: 'Tax was deleted'
          }
        else
          {
            errors: ["id: #{id}", 'Tax not found'],
            message: ''
          }
        end
      end
    end
  end
end
