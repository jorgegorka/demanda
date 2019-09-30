module Orders
  class PriceModifiers
    attr_reader :order

    def initialize(order)
      @order = order
    end

    def add
      modifiers = ::PriceModifiers::Finder.for_order(order)
      modifiers.each { |modifier| add_to_order(modifier) }
    end

    protected

    def add_to_order(modifier)
      price_modifier = {
        customer_id: modifier.customer_id,
        amount_cents: modifier.amount,
        percentage_cents: modifier.percentage,
        price_modifier_id: modifier.id
      }
      order.order_price_modifiers.create(price_modifier)
    end
  end
end
