# frozen_string_literal: true

module Mutations
  class AdminMutation < AuthorisedMutation
    def initialize(options)
      super(options)

      authorise_admin
    end

    protected

    def authorise_admin
      raise GraphQL::ExecutionError, 'Not allowed' unless context[:current_user].admin?
    end
  end
end
