# frozen_string_literal: true

module Mutations
  module Translation
    class Create < Mutations::ManagerMutation
      graphql_name 'CreateTranslation'

      argument :name, String, required: true
      argument :parent_type, Types::TranslationTypeEnum, required: true
      argument :parent_id, String, required: true
      argument :language_id, String, required: true
      argument :description, String, required: false

      field :errors, [String], null: true
      field :translation, Types::TranslationType, null: true

      def resolve(params)
        translation = Translations::Persistence.new(current_account).create(params)
        {
          errors: translation.errors.full_messages,
          translation: translation
        }
      end
    end
  end
end
