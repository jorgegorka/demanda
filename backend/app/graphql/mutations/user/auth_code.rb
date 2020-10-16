# frozen_string_literal: true

module Mutations
  module User
    class AuthCode < Mutations::BaseMutation
      graphql_name 'UserAuthCode'

      argument :email, String, required: true

      field :errors, [String], null: true

      def resolve(email:)
        user = current_account.users.find_by(email: email)
        user.generate_magic_login_token! if user

        { errors: [] }
      end
    end
  end
end
