# module Orders
#   class Persistence
#     class << self
#       def set_modifiers(order)
#         update_items(order.order_items)
#       end
#
#       protected
#
#       def update_items(order_items)
#         order_items.each { |order_item| calculate_price(order_item) }
#       end
#
#       def calculate_price(order_item)
#         OrderItems::PriceModifiers.new(order_item).add
#       end
#     end
#   end
# end
