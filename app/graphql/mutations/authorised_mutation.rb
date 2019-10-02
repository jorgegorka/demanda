module Mutations
  class AuthorisedMutation < BaseMutation
    protected

    def authorise_user
      return true if context[:current_user].present?

      raise GraphQL::ExecutionError, 'User not signed in'
    end

    def current_user
      context[:current_user]
    end

    def current_account
      return if current_user.blank?

      current_user.account
    end
  end
end
