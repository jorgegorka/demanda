module Types
  class OrderStatusType < Types::BaseEnum
    value 'Card', value: :card
    value 'Confirmed', value: :confirmed
    value 'Delivered', value: :delivered
    value 'Received', value: :received
    value 'Rejected', value: :rejected
    value 'Cancelled', value: :cancelled
  end
end
