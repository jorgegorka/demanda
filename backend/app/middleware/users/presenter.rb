# frozen_string_literal: true

module Users
  class Presenter
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def for_token
      {
        user_id: user.uuid,
        account_id: user.account.uuid,
        role: user.role,
        name: user.name
      }
    end
  end
end
