module Mutations
  module Language
    class Delete < Mutations::AuthorisedMutation
      graphql_name 'DeleteLanguage'

      argument :id, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(id:)
        language = current_account.languages.find_by(uuid: id)

        if language
          language.destroy
          {
            errors: language.errors.full_messages,
            message: language.destroyed?
          }
        else
          {
            errors: ["id: #{id}", 'Language not found'],
            message: ''
          }
        end
      end
    end
  end
end
