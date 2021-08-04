module Mutations
  class AuthorisedMutation < BaseMutation
    def ready?(**args)
      return true if context[:current_user].present? && context[:current_account].present?

      raise GraphQL::ExecutionError, 'Invalid user'
    end
  end
end
