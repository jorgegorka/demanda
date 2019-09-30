module Resolvers
  class Base < GraphQL::Schema::Resolver

    # argument_class Arguments::Base

    protected

    def authorize_user
      return true if context[:current_user].present?

      raise GraphQL::ExecutionError, "User not signed in"
    end
  end
end