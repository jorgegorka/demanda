# frozen_string_literal: true

module Mutations
  class AdminMutation < AuthorisedMutation
    def ready?(**args)
      return true if context[:current_user].admin?

      raise GraphQL::ExecutionError, 'Not allowed'
    end
  end
end
