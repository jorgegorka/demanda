module Orders
  class FromCart
    class << self
      def create(cart, payment_type, amount)
        new(cart, payment_type, amount).create
      end
    end

    def initialize(cart, payment_type, amount)
      @cart = cart
      @payment_type = payment_type
      @amount = amount
    end

    def create
      create_order
      add_payment
    end

    private

    attr_reader :cart, :order, :payment_type, :amount

    def user
      cart.user
    end

    def create_order
      @order = Orders::Persistence.new(user).create
      add_cart_items
      order.save
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

    def add_payment
      order.payments.create(origin: payment_type, total: amount)
    end
  end
end
