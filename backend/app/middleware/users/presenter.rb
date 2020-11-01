module Users
  class Presenter
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def for_token
      {
        user_id: user.uuid,
        account_id: user.account.uuid
      }
    end
  end
end
