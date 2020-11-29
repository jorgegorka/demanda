# frozen_string_literal: true

module Carts
  class Consolidate
    def initialize(user, payment_type, amount)
      @user = user
      @payment_type = payment_type
      @amount = amount
    end

    def to_order
      Orders::FromCart.create(cart)
      user.update(cart: nil)
    end

    private

    attr_reader :cart_id, :user

    def cart
      @cart ||= user.cart
    end
  end
end
