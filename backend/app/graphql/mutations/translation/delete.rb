module Mutations
  module Translation
    class Delete < Mutations::AuthorisedMutation
      graphql_name 'DeleteTranslation'

      argument :id, String, required: true
      argument :parent_type, Types::TranslationTypeEnum, required: true
      argument :parent_id, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(params)
        translation = Translations::Persistence.new(current_account).destroy(params)

        {
          errors: translation.errors.full_messages,
          message: translation.destroyed?
        }
      end
    end
  end
end
