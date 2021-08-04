module Carts
  class Persistence
    attr_reader :cart, :account, :user

    def initialize(cart_info)
      @account = cart_info[:account]
      @user = cart_info[:user]
      @cart = find_cart(cart_info[:cart_id])
    end

    def update(params)
      update_product_quantity(params)

      cart
    end

    protected

    def find_cart(cart_id)
      cart_id ? account.carts.find_by(uuid: cart_id) : create_cart
    end

    def create_cart
      if user
        user.cart || account.carts.create(user: user)
      else
        account.carts.create
      end
    end

    def update_product_quantity(params)
      product = find_product(params[:product_id])

      return unless product

      update_quantity(product, params[:quantity])
    end

    def remove_product(product_uuid)
      product = find_product(product_uuid)
      cart.cart_items.where(product: product).destroy_all if product
    end

    def find_product(product_uuid)
      @find_product ||= account.products.find_by(uuid: product_uuid)
    end

    def update_quantity(product, quantity)
      cart_item = cart.cart_items.find_by(product: product)

      if cart_item
        !quantity.positive? ? remove_product(product.uuid) : cart_item.update(quantity: quantity)
      else
        cart.cart_items.create(product: product, quantity: quantity)
      end
    end
  end
end
