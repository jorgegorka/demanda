module PriceModifiers
  # Find active price modifiers
  class Finder
    class << self
      cattr_accessor :query

      def for_order(order)
        self.query = order.account.price_modifiers.active.for_orders
        date_filter(order.created_at)
        customer_filter(order.customer_id)
        coupon_filter(order.coupon&.code)

        query
      end

      def for_product(order_item)
        self.query = order_item.order.account.price_modifiers.active.for_products
        date_filter(order_item.order.created_at)
        date_filter(order_item.order.created_at)
        customer_filter(order_item.order.customer_id)
        coupon_filter(order_item.order.coupon&.code)
        .where('(PRODUCT_ID = ? OR CATEGORY_ID = ?)', order_item.product_id, order_item.product.category_id)

        query
      end

      protected

      def date_filter(created_at)
        self.query = query.where('(:created_at BETWEEN START_AT AND END_AT) OR (END_AT IS NULL AND :created_at >= START_AT)', { created_at: created_at })
      end

      def customer_filter(customer_id)
        self.query = query.where('(CUSTOMER_ID IS NULL OR CUSTOMER_ID = ?)', customer_id)
      end

      def coupon_filter(coupon_code)
        self.query = query.where('(CODE IS NULL OR CODE = ?)', coupon_code)
      end
    end
  end
end
