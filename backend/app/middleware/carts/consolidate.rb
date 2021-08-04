module Carts
  class Consolidate
    def initialize(user, payment_type, amount)
      @user = user
      @payment_type = payment_type
      @amount = amount
    end

    def to_order
      Orders::FromCart.create(cart, payment_type, amount)
      user.update(cart: nil)
    end

    private

    attr_reader :cart_id, :user, :payment_type, :amount

    def cart
      @cart ||= user.cart
    end
  end
end
