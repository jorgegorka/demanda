module Orders
  class PriceModifiers
    attr_reader :order

    def initialize(order)
      @order = order
    end

    def add
      modifiers = ::Price::ModifiersFinder.for_order(order)
      modifiers.each { |modifier| add_to_order(modifier) }
    end

    protected

    def add_to_order(modifier)
      price_modifier = {
        customer_id: modifier.customer_id,
        price_modifier_id: modifier.id,
        amount: modifier.amount,
        percentage: modifier.percentage,
        minimum_quantity: modifier.minimum_quantity,
        minimum_price: modifier.minimum_price
      }
      order.order_price_modifiers.create(price_modifier)
    end
  end
end
