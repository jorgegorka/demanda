# frozen_string_literal: true

module Orders
  class PriceModifiers
    attr_reader :order

    def initialize(order)
      @order = order
    end

    def add
      modifiers = ::PriceModifiers::Finder.global(order)
      modifiers.each { |modifier| add_to_order(modifier) }
    end

    def update_total
      order.order_items.each(&:update_total)
      order.update_total
    end

    protected

    def add_to_order(modifier)
      price_modifier = {
        user_id: modifier.user_id,
        price_modifier_id: modifier.id,
        amount: modifier.amount,
        percentage: modifier.percentage,
        minimum_quantity: modifier.minimum_quantity,
        minimum_price: modifier.minimum_price
      }
      order.order_price_modifiers.build(price_modifier)
    end
  end
end
