# frozen_string_literal: true

module Customers
  class Persistence
    attr_reader :account, :current_user

    def initialize(account, current_user = nil)
      @account = account
      @current_user = current_user
    end

    def create(params)
      if current_user
        current_user.customer
      else
        language = find_language(params)
        customer = account.customers.create(name: params[:name], language: language)
        customer.user = account.users.create(email: params[:email], password: params[:password])

        customer
      end
    end

    protected

    def find_language(params)
      language_id = params.delete(:language_id) || account.default_language

      account.languages.find_by(uuid: language_id)
    end
  end
end
