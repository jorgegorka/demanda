# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :categories, resolver: Resolvers::Categories
    field :languages, resolver: Resolvers::Languages
    field :taxes, resolver: Resolvers::Taxes
    field :discounts, resolver: Resolvers::Discounts
    field :products, resolver: Resolvers::Products
    field :carts, resolver: Resolvers::Carts
    field :current_user, resolver: Resolvers::CurrentUser
    field :comments, resolver: Resolvers::Comments
  end
end
