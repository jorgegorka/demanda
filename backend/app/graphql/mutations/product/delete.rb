# frozen_string_literal: true

module Mutations
  module Product
    class Delete < Mutations::ManagerMutation
      graphql_name 'DeleteProduct'

      argument :id, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(id:)
        authorise_user
        product = current_account.products.find_by(uuid: id)

        if product
          product.destroy
          {
            errors: product.errors.full_messages,
            message: 'Product was deleted'
          }
        else
          {
            errors: ["id: #{id}", 'Product not found'],
            message: ''
          }
        end
      end
    end
  end
end
