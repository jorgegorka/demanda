module Setup
  class NewAccount
    attr_reader :errors, :user_info, :account_name

    def initialize(user_info, account_name)
      @user_info = user_info
      @account_name = account_name
      @errors = []
    end

    def create
      create_account_and_admin

      { token: @token, errors: errors }
    end

    private

    def create_account_and_admin
      account = Account.new(name: account_name)
      user = account.users.new(user_info.merge(name: account_name))
      user.role = :admin

      if account.valid?
        account.save
        @token = Jwt::TokenProvider.issue_token(::Users::Presenter.new(user).for_token)
      else
        user.valid?
        @token = 'invalid'
        errors << account.errors.full_messages + user.errors.full_messages
      end
    end
  end
end
