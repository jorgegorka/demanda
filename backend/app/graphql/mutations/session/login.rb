# frozen_string_literal: true

module Mutations
  module Session
    class Login < Mutations::BaseMutation
      graphql_name 'LoginUser'

      argument :email, String, required: true
      argument :password, String, required: true

      field :errors, [String], null: true
      field :token, String, null: true

      def resolve(email:, password:)
        user = ::User.authenticate(email, password)

        if user
          token = Jwt::TokenProvider.issue_token(::Users::Presenter.new(user).for_token)

          { token: token, errors: [] }
        else
          invalid_response
        end
      end

      protected

      def invalid_response
        { token: 'invalid', errors: ['Invalid email or password'] }
      end
    end
  end
end
