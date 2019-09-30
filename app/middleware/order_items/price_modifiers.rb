module OrderItems
  class PriceModifiers
    attr_reader :order_item

    def initialize(order_item)
      @order_item = order_item
    end

    def add
      modifiers = ::PriceModifiers::Finder.for_product(order_item)
      modifiers.each { |modifier| add_to_item(modifier) }
    end

    protected

    def add_to_item(modifier)
      price_modifier = {
        customer_id: modifier.customer_id,
        category_id: modifier.category_id,
        product_id: modifier.product_id,
        amount_cents: modifier.amount,
        percentage_cents: modifier.percentage,
        price_modifier_id: modifier.id
      }
      order_item.order_price_modifiers.create(price_modifier)
    end
  end
end
