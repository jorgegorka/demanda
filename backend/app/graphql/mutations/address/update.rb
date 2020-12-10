# frozen_string_literal: true

module Mutations
  module Address
    class Update < Mutations::AuthorisedMutation
      graphql_name 'UpdateAddress'

      argument :id, String, required: true
      argument :first_address, String, required: false
      argument :second_address, String, required: false
      argument :postal_code, String, required: false
      argument :city, String, required: false
      argument :country, String, required: false
      argument :name, String, required: false

      field :errors, [String], null: true
      field :address, Types::Address, null: true

      def resolve(params)
        address = Addresses::Persistence.new(current_user).update(params)

        {
          errors: address.errors.full_messages,
          address: address
        }
      end
    end
  end
end
