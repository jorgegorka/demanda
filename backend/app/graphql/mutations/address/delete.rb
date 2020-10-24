# frozen_string_literal: true

module Mutations
  module Address
    class Delete < Mutations::AuthorisedMutation
      graphql_name 'DeleteAddress'

      argument :id, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(id:)
        address = context[:current_user].addresses.find_by(uuid: id)

        if address
          address.destroy
          {
            errors: address.errors.full_messages,
            message: 'Address was deleted'
          }
        else
          {
            errors: ["id: #{id}", 'Address not found'],
            message: ''
          }
        end
      end
    end
  end
end
