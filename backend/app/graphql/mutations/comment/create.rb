# frozen_string_literal: true

module Mutations
  module Comment
    class Create < Mutations::BaseMutation
      graphql_name 'CreateComment'

      argument :description, String, required: true
      argument :parent_id, String, required: true
      argument :parent_type, String, required: true
      argument :language_id, String, required: true
      argument :user_email, String, required: false

      field :errors, [String], null: true
      field :comment, Types::CommentType, null: true

      def resolve(params)
        user = assign_user(params[:user_email])
        params[:user_id] = user.id
        comment = Comments::Persistence.new(current_account).create(params)
        {
          errors: comment.errors.full_messages,
          comment: comment
        }
      end

      def assign_user(email)
        context[:current_user].presence || User.for_comment(email, context[:current_account])
      end
    end
  end
end
