module Mutations
  module Language
    class Create < Mutations::AuthorisedMutation
      graphql_name 'CreateLanguage'

      argument :name, String, required: true
      argument :description, String, required: false

      field :errors, [String], null: true
      field :language, Types::LanguageType, null: true

      def resolve(params)
        language = Languages::Persistence.new(current_account).create(params)
        {
          errors: language.errors.full_messages,
          language: language
        }
      end
    end
  end
end
