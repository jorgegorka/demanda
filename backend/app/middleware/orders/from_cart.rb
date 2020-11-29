# frozen_string_literal: true

module Orders
  class FromCart
    class << self
      def create(cart)
        new(cart).create
      end
    end

    def initialize(cart)
      @cart = cart
    end

    def create
      @order = user.orders.create(account: cart.user.account)
      add_cart_items
      order.save
    end

    private

    attr_reader :cart, :order

    def user
      cart.user
    end

    def add_cart_items
      cart.cart_items.all.each do |cart_item|
        product = cart_item.product
        order.order_items.create(
          product: product,
          quantity: cart_item.quantity.amount,
          price: product.price.amount,
          price_includes_taxes: product.price_includes_taxes
        )
      end
    end
  end
end
