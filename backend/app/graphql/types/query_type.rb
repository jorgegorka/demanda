module Types
  class QueryType < Types::BaseObject
    field :categories, resolver: Resolvers::Categories
    field :languages, resolver: Resolvers::Languages
    field :taxes, resolver: Resolvers::Taxes
    field :discounts, resolver: Resolvers::Discounts
    field :products, resolver: Resolvers::Products
    field :carts, resolver: Resolvers::Carts

    field :current_user, Types::UserType, null: true do
      description 'Returns the current logged in user'
    end

    def me(demo: false)
      context[:current_user]
    end
  end
end
