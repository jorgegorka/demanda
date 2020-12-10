# frozen_string_literal: true

module Mutations
  module Comment
    class Update < Mutations::ManagerMutation
      graphql_name 'UpdateComment'

      argument :id, String, required: true
      argument :reply_description, String, required: false
      argument :approved, Boolean, required: false

      field :errors, [String], null: true
      field :comment, Types::Comment, null: true

      def resolve(params)
        comment = Comments::Persistence.new(current_account).update(params)

        {
          errors: comment.errors.full_messages,
          comment: comment
        }
      end
    end
  end
end
