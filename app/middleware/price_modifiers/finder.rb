module PriceModifiers
  # Find active price modifiers
  class Finder
    class << self
      def for_order(order)
        order.account.price_modifiers.active.for_orders
          .where('(:created_at BETWEEN START_AT AND END_AT) OR (END_AT IS NULL AND :created_at >= START_AT)', { created_at: order.created_at })
          .where('(CUSTOMER_ID IS NULL OR CUSTOMER_ID = ?)', order.customer_id)
      end

      def for_product(order_item)
        order_item.order.account.price_modifiers.active.for_products
          .where('(:created_at BETWEEN START_AT AND END_AT) OR (END_AT IS NULL AND :created_at >= START_AT)', { created_at: order_item.order.created_at })
          .where('(CUSTOMER_ID IS NULL OR CUSTOMER_ID = ?)', order_item.order.customer_id)
          .where('(PRODUCT_ID = ? OR CATEGORY_ID = ?)', order_item.product_id, order_item.product.category_id)
      end
    end
  end
end
