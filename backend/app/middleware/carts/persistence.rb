module Carts
  class Persistence
    attr_reader :cart, :account, :customer

    def initialize(account, cart_id, customer_id)
      @account = account
      @customer  = account.customers.find_by(uuid: customer_id)
      @cart = find_cart(cart_id)
    end

    def update(params)
      params[:quantity] == 0 ? remove_product(params[:product_id]) : update_product(params)
    end

    protected

    def find_cart(cart_id)
      cart_id ? account.carts.find_by(uuid: cart_id) : create_cart
    end

    def create_cart
      if customer
        customer.cart || account.carts.create(customer: customer)
      else
        account.carts.create
      end
    end

    def update_product(params)
      product = find_product(params[:product_id])

      return unless product

      add_or_update_product(product, params[:quantity])
    end

    def remove_product(product_id)
      product = find_product(product_id)
      cart.cart_items.where(product: product).destroy_all if product
    end

    def find_product(product_id)
      account.products.find_by(uuid: product_id)
    end

    def add_or_update_product(product, quantity)
      cart_item = cart.cart_items.find_by(product: product)

      if cart_item
        cart_item.update(quantity: cart_item.quantity.amount + quantity, price: product.price)

        cart_item
      else
        cart.cart_items.create(product: product, quantity: quantity, price: product.price)
      end
    end
  end
end