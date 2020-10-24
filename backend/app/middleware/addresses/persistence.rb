# frozen_string_literal: true

module Addresses
  class Persistence
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def create(params)
      address = user.addresses.create(params)

      address
    end

    def update(params)
      address = user.addresses.find_by(uuid: params.delete(:id))
      address.update(params)

      address
    end

    def destroy(address)
      address.destroy
    end
  end
end
