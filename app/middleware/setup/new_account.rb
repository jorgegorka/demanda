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

      if errors.any?
        {
          errors: errors
        }
      else
        {
          errors: []
        }
      end
    end

    private

    def create_account_and_admin
      account = Account.new(name: account_name)
      user = account.users.new(user_info)
      user.role = :admin

      if account.valid?
        account.save
      else
        user.valid?
        errors << account.errors.full_messages + user.errors.full_messages
      end
    end
  end
end
