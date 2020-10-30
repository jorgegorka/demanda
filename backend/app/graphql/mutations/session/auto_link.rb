# frozen_string_literal: true

module Mutations
  module Session
    class AutoLink < Mutations::BaseMutation
      graphql_name 'AutoLink'

      argument :email, String, required: true

      field :errors, [String], null: true

      def resolve(email:)
        user = ::User.find_by(email: email)
        if user
          user.generate_magic_login_token!
          AutoLoginMailer.with(user: user).magic_login_email.deliver_now
        end

        { errors: [] }
      end
    end
  end
end
