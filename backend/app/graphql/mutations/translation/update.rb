# frozen_string_literal: true

module Mutations
  module Translation
    class Update < Mutations::ManagerMutation
      graphql_name 'UpdateTranslation'

      argument :id, String, required: true
      argument :name, String, required: true
      argument :parent_type, Types::TranslationEnum, required: true
      argument :parent_id, String, required: true
      argument :language_id, String, required: false
      argument :description, String, required: false

      field :errors, [String], null: true
      field :translation, Types::Translation, null: true

      def resolve(params)
        translation = Translations::Persistence.new(current_account).update(params)

        {
          errors: translation.errors.full_messages,
          translation: translation
        }
      end
    end
  end
end
