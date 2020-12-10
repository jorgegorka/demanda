# frozen_string_literal: true

module Types
  class OrderStatusEnum < Types::BaseEnum
    value 'Received', value: 'received'
    value 'Approved', value: 'approved'
    value 'OnRoute', value: 'on_route'
    value 'Delivered', value: 'delivered'
    value 'Rejected', value: 'rejected'
    value 'Cancelled', value: 'cancelled'
  end
end
