# frozen_string_literal: true

module Mutations
  module User
    class Update < Mutations::AuthorisedMutation
      graphql_name 'UpdateUser'

      argument :id, String, required: false
      argument :name, String, required: true
      argument :phone, String, required: false

      field :errors, [String], null: true
      field :user, Types::UserType, null: true

      def resolve(params)
        user = Users::Persistence.new(current_account, updated_user(params[:id])).update(params)

        {
          errors: user.errors.full_messages,
          user: user
        }
      end

      private

      def updated_user(uuid)
        #current_user.is_manager? ? find_user(uuid) : current_user
        current_user
      end

      def find_user(uuid)
        current_account.users.find_by(uuid: uuid)
      end
    end
  end
end
