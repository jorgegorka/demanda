module Mutations
  module Sessions
    class Signup < Mutations::BaseMutation
      argument :email, String, required: true
      argument :password, String, required: true
      argument :firstName, String, required: true
      argument :lastName, String, required: true
      argument :accountName, String, required: true

      field :errors, [String], null: false

      def resolve(email:, password:, first_name:, last_name:, account_name:)
        user_info = {
          email: email,
          password: password,
          first_name: first_name,
          last_name: last_name
        }

        Setup::NewAccount.new(user_info, account_name).create
      end
    end
  end
end
