module Mutations
  module Sessions
    class Login < Mutations::BaseMutation
      graphql_name "LoginUser"

      argument :email, String, required: true
      argument :password, String, required: true

      field :user, Types::UserType, null: true
      field :errors, [String], null: true

      def resolve(email:, password:)
        raise 'already logged in ' if context[:current_user]
        user = User.find_for_authentication(email: email)
        return invalid_response if !user

        is_valid_for_auth = user.valid_for_authentication?{ user.valid_password?(password) }

        if is_valid_for_auth
          context[:login].call("user", user)
          # Rails.logger.info context[:login]
          # context[:current_user] = user
          { user: user, errors: [] }
        else
          invalid_response
        end
      end

      protected

      def invalid_response
        { user: User.new, errors: ['Invalid email or password'] }
      end
    end
  end
end