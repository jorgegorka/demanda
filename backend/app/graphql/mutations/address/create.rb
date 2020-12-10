# frozen_string_literal: true

module Mutations
  module Address
    class Create < Mutations::AuthorisedMutation
      graphql_name 'CreateAddress'

      argument :first_address, String, required: true
      argument :second_address, String, required: false
      argument :postal_code, String, required: true
      argument :city, String, required: true
      argument :country, String, required: true
      argument :name, String, required: false

      field :errors, [String], null: true
      field :address, Types::Address, null: true

      def resolve(params)
        address = Addresses::Persistence.new(current_user).create(params)
        {
          errors: address.errors.full_messages,
          address: address
        }
      end
    end
  end
end
