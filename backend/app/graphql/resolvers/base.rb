# frozen_string_literal: true

module Resolvers
  class Base < GraphQL::Schema::Resolver
    attr_reader :db_query
    include Resolvers::QueryFinders

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
      context[:current_account]
    end
  end
end
