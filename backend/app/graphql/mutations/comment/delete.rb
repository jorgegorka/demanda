# frozen_string_literal: true

module Mutations
  module Comment
    class Delete < Mutations::ManagerMutation
      graphql_name 'DeleteComment'

      argument :id, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(id:)
        comment = ::Comment.for_account(context[:current_account].id).where(uuid: id).first

        if comment
          comment.destroy
          {
            errors: comment.errors.full_messages,
            message: 'Comment was deleted'
          }
        else
          {
            errors: ["id: #{id}", 'Comment not found'],
            message: ''
          }
        end
      end
    end
  end
end
