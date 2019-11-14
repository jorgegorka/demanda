module Mutations
  module Session
    class Signup < Mutations::BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true
      argument :name, String, required: true

      field :errors, [String], null: true
      field :token, String, null: true

      def resolve(email:, password:, name:)
        Setup::NewAccount.new({ email: email, password: password }, name).create
      end
    end
  end
end
