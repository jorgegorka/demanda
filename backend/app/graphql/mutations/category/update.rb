module Mutations
  module Category
    class Update < Mutations::AuthorisedMutation
      graphql_name 'UpdateCategory'

      argument :id, String, required: true
      argument :name, String, required: true

      field :errors, [String], null: true
      field :category, Types::CategoryType, null: true

      def resolve(params)
        category = Categories::Persistence.new(current_account).update(params)

        {
          errors: category.errors.full_messages,
          category: category
        }
      end
    end
  end
end
