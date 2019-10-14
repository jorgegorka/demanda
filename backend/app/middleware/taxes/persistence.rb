module Taxes
  class Persistence
    include PriceModifiers::Persistence
    attr_reader :account, :price_modifier

    def initialize(account)
      @account = account
    end

    def create(params)
      @price_modifier = account.taxes.new
      add_params(params)
      price_modifier.save

      price_modifier
    end

    def update(params)
      @price_modifier = account.taxes.find_by(uuid: params.delete(:id))
      if price_modifier
        add_params(params)
        price_modifier.save
      else
        @price_modifier = account.taxes.new
        price_modifier.errors.add(:base, 'Tax not found')
      end

      price_modifier
    end
  end
end
