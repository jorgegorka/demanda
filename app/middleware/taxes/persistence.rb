module Taxes
  class Persistence
    attr_reader :account, :tax

    def initialize(account)
      @account = account
    end

    def create(params)
      @tax = account.taxes.new
      add_params(params)
      tax.save

      tax
    end

    def update(params)
      @tax = account.taxes.find_by(uuid: params.delete(:id))
      if tax
        add_params(params)
        tax.save
      else
        @tax = account.taxes.new
        tax.errors.add(:base, 'Tax not found')
      end

      tax
    end

    protected

    def add_params(params)
      find_customer(params.delete(:customer_id))
      find_category(params.delete(:category_id))
      find_product(params.delete(:product_id))
      tax.update(params)
    end

    def find_category(category_id)
      return unless category_id

      tax.category = account.categories.find_by(uuid: category_id)
    end

    def find_customer(customer_id)
      return unless customer_id

      tax.customer = account.customers.find_by(uuid: customer_id)
    end

    def find_product(product_id)
      return unless product_id

      tax.product = account.products.find_by(uuid: product_id)
    end
  end
end
