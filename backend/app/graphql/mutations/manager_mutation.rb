module Mutations
  class ManagerMutation < AuthorisedMutation
    def ready?(**args)
      return true if context[:current_user].is_manager?

      raise GraphQL::ExecutionError, 'Not allowed' unless context[:current_user].is_manager?
    end
  end
end
