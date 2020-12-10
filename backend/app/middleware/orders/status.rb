# frozen_string_literal: true

module Orders
  class Status
    def initialize(order)
      @order = order
    end

    def payment_updated
      return if order.total.amount > order.total_paid

      order.update(status: :approved)
      order.order_logs.create(description: "Payment of order completed. Order status changed to: #{order.status}")
    end

    private

    attr_reader :order
  end
end
