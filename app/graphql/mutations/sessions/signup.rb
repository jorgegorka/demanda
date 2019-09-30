module Mutations
  module Sessions
    class Signup < Mutations::BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true
      argument :accountName, String, required: true

      field :errors, [String], null: true
      field :token, String, null: true

      def resolve(email:, password:, account_name:)
        Setup::NewAccount.new({ email: email, password: password }, account_name).create
      end
    end
  end
end
