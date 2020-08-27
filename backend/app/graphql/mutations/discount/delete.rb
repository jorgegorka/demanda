# frozen_string_literal: true

module Mutations
  module Discount
    class Delete < Mutations::ManagerMutation
      graphql_name 'DeleteDiscount'

      argument :id, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(id:)
        discount = current_account.discounts.find_by(uuid: id)

        if discount
          discount.destroy
          {
            errors: discount.errors.full_messages,
            message: 'Discount was deleted'
          }
        else
          {
            errors: ["id: #{id}", 'Discount not found'],
            message: ''
          }
        end
      end
    end
  end
end
