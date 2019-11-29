module Mutations
  module Attachment
    class Delete < Mutations::AuthorisedMutation
      graphql_name 'DeleteAttachment'

      argument :id, String, required: true
      argument :parent_type, Types::AttachmentTypeEnum, required: true
      argument :parent_id, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(params)
        attachment = Attachments::Persistence.new(current_account).destroy(params)

        {
          errors: attachment.errors.full_messages,
          message: attachment.destroyed?
        }
      end
    end
  end
end
