# frozen_string_literal: true

module Mutations
  module Attachment
    class Create < Mutations::AuthorisedMutation
      graphql_name 'CreateAttachment'

      argument :parent_type, Types::AttachmentTypeEnum, required: true
      argument :parent_id, String, required: true
      argument :title, String, required: true

      field :errors, [String], null: true
      field :attachment, Types::AttachmentType, null: true

      def resolve(params)
        attachment = Attachments::Persistence.new(current_account).create(params)
        {
          errors: attachment.errors.full_messages,
          attachment: attachment
        }
      end
    end
  end
end
