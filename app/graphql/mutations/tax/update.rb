module Mutations
  module Tax
    class Update < Mutations::AuthorisedMutation
      graphql_name 'UpdateTax'

      argument :uuid, String, required: true
      argument :name, String, required: true
      argument :product_id, String, required: false
      argument :category_id, String, required: false
      argument :customer_id, String, required: false
      argument :active, Boolean, required: false
      argument :percentage, Integer, required: false
      argument :amount, Integer, required: false
      argument :start_at, GraphQL::Types::ISO8601DateTime, required: false
      argument :end_at, GraphQL::Types::ISO8601DateTime, required: false
      argument :minimum_quantity, Integer, required: false
      argument :minimum_price, Integer, required: false

      field :errors, [String], null: true
      field :tax, Types::TaxType, null: true

      def resolve(params)
        authorise_user
        tax = current_account.taxes.find_by(uuid: params.delete(:uuid))
        tax.update(params)
        {
          errors: tax.errors.full_messages,
          tax: tax
        }
      end
    end
  end
end
