module Price
  # Find active price modifiers
  class ModifiersFinder
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
        minimum_quantity_filter(order_item.quantity.amount)
        minimum_price_filter((order_item.quantity.amount * order_item.price.amount).to_f)
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

      def minimum_quantity_filter(quantity)
        self.query = query.where('(MINIMUM_QUANTITY_CENTS = 0 OR MINIMUM_QUANTITY_CENTS <= ?)', quantity * 100)
      end

      def minimum_price_filter(price)
        self.query = query.where('(MINIMUM_PRICE_CENTS = 0 OR MINIMUM_PRICE_CENTS <= ?)', price * 100)
      end
    end
  end
end
