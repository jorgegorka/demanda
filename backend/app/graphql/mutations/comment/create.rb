# frozen_string_literal: true

module Mutations
  module Comment
    class Create < Mutations::BaseMutation
      graphql_name 'CreateComment'

      argument :description, String, required: true
      argument :rating, Integer, required: false
      argument :parent_id, String, required: true
      argument :parent_type, String, required: true
      argument :language_id, String, required: false
      argument :user_email, String, required: false
      argument :user_name, String, required: false

      field :errors, [String], null: true
      field :comment, Types::CommentType, null: true

      def resolve(params)
        user = assign_user(params.delete(:user_email), params.delete(:user_name))
        params[:user_id] = user.id
        comment = Comments::Persistence.new(current_account).create(params)
        {
          errors: comment.errors.full_messages,
          comment: comment
        }
      end

      def assign_user(email, name)
        ::User.generate_from_email(user_email(email), context[:current_account], name)
      end

      def user_email(email)
        context[:current_user].present? ? context[:current_user].email : email
      end
    end
  end
end
