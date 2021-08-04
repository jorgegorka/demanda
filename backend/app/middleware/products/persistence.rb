module Products
  class Persistence
    attr_reader :account, :product

    def initialize(account)
      @account = account
    end

    def create(params)
      @product = account.products.new
      add_tags(params)
      add_params(params)

      product
    end

    def update(params)
      @product = account.products.find_by(uuid: params.delete(:id))
      if product
        add_tags(params)
        add_params(params)
      else
        @product = account.products.new
        product.errors.add(:base, 'Product not found')
      end

      product
    end

    protected

    def add_params(params)
      find_category(params.delete(:category_id))
      product.update(params)
    end

    def add_tags(params)
      tags = params.delete(:tags) || ''

      product.tag_names = tags.split(',').map(&:strip)
    end

    def find_category(category_id)
      return if category_id.blank?

      product.category = account.categories.find_by(uuid: category_id)
    end
  end
end
