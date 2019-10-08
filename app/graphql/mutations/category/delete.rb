module Mutations
  module Category
    class Delete < Mutations::AuthorisedMutation
      graphql_name 'DeleteCategory'

      argument :id, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(id:)
        authorise_user
        category = current_account.categories.find_by(uuid: id)

        if category
          category.destroy
          {
            errors: category.errors.full_messages,
            message: category.destroyed?
          }
        else
          {
            errors: ["id: #{id}", 'Category not found'],
            message: ''
          }
        end
      end
    end
  end
end
