# frozen_string_literal: true

module Price
  class ModifiersCalculator
    attr_reader :order_price_modifier

    def initialize(order_price_modifier)
      @order_price_modifier = order_price_modifier
    end

    def update_price
      order_price_modifier.price_modifier.tax? ? add_to_tax : add_to_discount
    end

    protected

    def add_to_tax
      item.total_tax += total_to_add
    end

    def add_to_discount
      item.total_discount += total_to_add
    end

    def item
      order_price_modifier.order.present? ? order_price_modifier.order : order_price_modifier.order_item
    end

    def total_to_add
      order_price_modifier.amount.zero? ? percentage_number : order_price_modifier.amount
    end

    def percentage_number
      Money.new(total_percentage.to_f * 100, 'EU2')
    end

    def total_percentage
      item.gross_price * order_price_modifier.percentage.amount / 100
    end
  end
end
