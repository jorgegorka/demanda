module Addresses
  class Persistence
    attr_reader :user

    def initialize(user)
      @user = user
    end

    def create(params)
      user.addresses.create(params)
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
