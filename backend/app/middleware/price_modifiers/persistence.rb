module PriceModifiers
  module Persistence
    protected

    def add_params(params)
      find_user(params.delete(:user_id))
      find_category(params.delete(:category_id))
      find_product(params.delete(:product_id))
      price_modifier.update(params)
    end

    def find_category(category_id)
      return if category_id.blank?

      price_modifier.category = account.categories.find_by(uuid: category_id)
    end

    def find_user(user_id)
      return if user_id.blank?

      price_modifier.user = account.users.find_by(uuid: user_id)
    end

    def find_product(product_id)
      return if product_id.blank?

      price_modifier.product = account.products.find_by(uuid: product_id)
    end
  end
end
