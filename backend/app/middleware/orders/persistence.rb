# frozen_string_literal: true

module Orders
  class Persistence
    def initialize(user)
      @user = user
    end

    def create(params)
      params[:account] = user.account
      user.orders.create(params)
    end

    private

    attr_reader :user
  end
end
