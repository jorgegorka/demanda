# frozen_string_literal: true

module Mutations
  module User
    class Update < Mutations::ManagerMutation
      graphql_name 'UpdateUser'

      argument :id, String, required: true
      argument :name, String, required: true

      field :errors, [String], null: true
      field :user, Types::UserType, null: true

      def resolve(id:, name:)
        user = current_account.users.find_by(uuid: id)
        user.update_attribute(:name, name)
        {
          errors: user.errors.full_messages,
          user: user
        }
      end
    end
  end
end
