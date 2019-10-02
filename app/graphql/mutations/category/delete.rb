module Mutations
  module Category
    class Delete < Mutations::AuthorisedMutation
      graphql_name 'DeleteCategory'

      argument :uuid, String, required: true

      field :errors, [String], null: true
      field :message, String, null: false

      def resolve(uuid:)
        authorise_user
        category = current_account.categories.find_by_uuid(uuid)

        if category.products.count.zero?
          category.destroy
          {
            errors: [],
            message: 'Category was deleted'
          }
        else
          {
            errors: ['Category should have no products associated.'],
            message: "Can't delete."
          }
        end
      end
    end
  end
end
