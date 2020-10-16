# frozen_string_literal: true

module Mutations
  module User
    class Create < Mutations::BaseMutation
      graphql_name 'CreateUser'

      argument :name, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true
      argument :language_id, String, required: false

      field :errors, [String], null: true
      field :user, Types::UserType, null: true

      def resolve(params)
        user = Users::Persistence.new(current_account, current_user).create(params)
        {
          errors: user.errors.full_messages,
          user: user
        }
      end
    end
  end
end
