module Resolvers
  class Base < GraphQL::Schema::Resolver

    # argument_class Arguments::Base

    protected

    def authorize_user
      return true if current_user.present?

      raise GraphQL::ExecutionError, 'User not signed in'
    end

    def current_user
      Rails.logger.info context[:current_user]
      context[:current_user]
    end

    def current_account
      return if current_user.blank?

      current_user.account
    end
  end
end
