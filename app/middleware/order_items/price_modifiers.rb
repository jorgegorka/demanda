module OrderItems
  class PriceModifiers
    attr_reader :order_item

    def initialize(order_item)
      @order_item = order_item
    end

    def add
      modifiers = ::Price::ModifiersFinder.for_product(order_item)
      modifiers.each { |modifier| add_to_item(modifier) }
    end

    protected

    def add_to_item(modifier)
      price_modifier = {
        customer_id: modifier.customer_id,
        category_id: modifier.category_id,
        product_id: modifier.product_id,
        amount: modifier.amount,
        percentage: modifier.percentage,
        minimum_quantity: modifier.minimum_quantity,
        minimum_price: modifier.minimum_price,
        price_modifier_id: modifier.id
      }
      order_item.order_price_modifiers.create(price_modifier)
    end
  end
end
