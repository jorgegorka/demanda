module Mutations
  module Category
    class Create < Mutations::AuthorisedMutation
      graphql_name 'CreateCategory'

      argument :name, String, required: true
      argument :parent_id, String, required: false, default_value: ''
      argument :translations, [Types::TranslationInput], required: false, default_value: []

      field :errors, [String], null: true
      field :category, Types::CategoryType, null: true

      def resolve(params)
        authorise_user
        category = Categories::Persistence.new(current_account).create(params)
        {
          errors: category.errors.full_messages,
          category: category
        }
      end
    end
  end
end
