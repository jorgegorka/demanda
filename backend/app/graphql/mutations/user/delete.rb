# frozen_string_literal: true

module Mutations
  module User
    class Delete < Mutations::ManagerMutation
      graphql_name 'DeleteUser'

      argument :id, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(id:)
        user = current_account.users.find_by(uuid: id)

        if user
          user.destroy
          {
            errors: user.errors.full_messages,
            message: user.destroyed?
          }
        else
          {
            errors: ["id: #{id}", 'User not found'],
            message: ''
          }
        end
      end
    end
  end
end
