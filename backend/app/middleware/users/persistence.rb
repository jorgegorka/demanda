# frozen_string_literal: true

module Users
  class Persistence
    attr_reader :account, :current_user

    def initialize(account, current_user = nil)
      @account = account
      @current_user = current_user
    end

    def create(params)
      return current_user if current_user.present?

      language = find_language(params)
      account.users.create(
        name: params[:name],
        language: language,
        email: params[:email],
        password: params[:password]
      )
    end

    def update(params)
      # comment = account.comments.find_by(uuid: params.delete(:id))
      current_user.update(name: params[:name], phone: params[:phone])

      current_user
    end

    protected

    def find_language(params)
      language_id = params.delete(:language_id) || account.default_language

      account.languages.find_by(uuid: language_id)
    end
  end
end
