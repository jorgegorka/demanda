# frozen_string_literal: true

module Mutations
  class ManagerMutation < AuthorisedMutation
    def initialize(options)
      super(options)

      authorise_manager
    end

    protected

    def authorise_manager
      raise GraphQL::ExecutionError, 'Not allowed' unless context[:current_user].is_manager?
    end
  end
end
