module Mutations
  module Category
    class Update < Mutations::AuthorisedMutation
      graphql_name 'UpdateCategory'

      argument :uuid, String, required: true
      argument :name, String, required: true

      field :errors, [String], null: true
      field :category, Types::CategoryType, null: true

      def resolve(uuid:, name:)
        authorise_user
        category = current_account.categories.find_by(uuid: uuid)
        category.update_attribute(:name, name)
        {
          errors: category.errors.full_messages,
          category: category
        }
      end
    end
  end
end
