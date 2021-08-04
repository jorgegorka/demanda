class Payment < ApplicationRecord
  include Uuidable

  belongs_to :order

  monetize :total_cents

  enum origin: { bank_transfer: 0, credit_card: 1, cash: 2 }

  after_create :update_order_status
  after_create :add_payment_log

  private

  def update_order_status
    Orders::Status.new(order).payment_updated
  end

  def add_payment_log
    order.order_logs.create(description: "#{origin}. Amount: #{total.amount}")
  end
end
