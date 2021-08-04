module PriceModifiers
  # Find active price modifiers
  class Finder
    cattr_accessor :query

    class << self
      def global(document)
        self.query = document.account.price_modifiers.active.global
        date_filter(document.created_at)
        user_filter(document.user_id)
        # coupon_filter(document.coupon&.code)
        minimum_price_filter(document.total_gross.to_f)

        query
      end

      def for_product(document_item, document)
        self.query = document.account.price_modifiers.active
        product_filter(document_item)
        date_filter(document.created_at)
        user_filter(document.user_id)
        # coupon_filter(document_item.order.coupon&.code)
        minimum_quantity_filter(document_item.quantity.amount)
        minimum_price_filter(document_item.total_gross.amount)

        query.order(:type, :updated_at)
      end

      protected

      def product_filter(document_item)
        self.query = query.where(
          '(PRODUCT_ID = ? OR CATEGORY_ID = ?)',
          document_item.product_id,
          document_item.product.category_id
        )
      end

      def date_filter(created_at)
        self.query = query.where(
          '(:created_at BETWEEN START_AT AND END_AT) OR (END_AT IS NULL AND :created_at >= START_AT)',
          { created_at: created_at }
        )
      end

      def user_filter(user_id)
        self.query = query.where('(USER_ID IS NULL OR USER_ID = ?)', user_id)
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
