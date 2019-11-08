module Mutations
  class AuthorisedMutation < BaseMutation
    def initialize(options)
      super(options)
      authorise_user
    end

    protected

    def authorise_user
      return true if context[:current_user].present? && context[:current_account].present?

      raise GraphQL::ExecutionError, 'Invalid user'
    end
  end
end
