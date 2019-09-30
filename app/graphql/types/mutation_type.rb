module Types
  class MutationType < Types::BaseObject
    field :signup, mutation: Mutations::Sessions::Signup
    field :login, mutation: Mutations::Sessions::Login

    # # Uncomment to enable features

    # field :update_user, UserType, null: true do
    #   description "Update user"
    #   argument :password, String, required: false
    #   argument :passwordConfirmation, String, required: false
    # end

    # def update_user(
    #     password: context[:current_user] ? context[:current_user].password : '',
    #     password_confirmation: context[:current_user] ? context[:current_user].password_confirmation : ''
    #   )
    #   user = context[:current_user]
    #   return nil if !user
    #   user.update!(
    #     password: password,
    #     password_confirmation: password_confirmation
    #   )
    #   user
    # end

    # field :send_reset_password_instructions, Boolean, null: true do
    #   description "Send password reset instructions to users email"
    #   argument :email, String, required: true
    # end
    # def send_reset_password_instructions(email:)
    #   user = User.find_by_email(email)
    #   return true if !user
    #   user.send_reset_password_instructions
    #   true
    # end

    # field :reset_password, Boolean, null: true do
    #   argument :password, String, required: true
    #   argument :passwordConfirmation, String, required: true
    #   argument :resetPasswordToken, String, required: true
    # end
    # def reset_password(password:, password_confirmation:, reset_password_token:)
    #   user = User.with_reset_password_token(reset_password_token)
    #   return false if !user
    #   user.reset_password(password, password_confirmation)
    # end
  end
end
