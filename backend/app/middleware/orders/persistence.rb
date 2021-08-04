module Orders
  class Persistence
    def initialize(user)
      @user = user
    end

    def create(params = {})
      params[:account] = user.account
      user.orders.create(params)
    end

    def update(params)
      @order_id = params[:id]
      order.update(status: params[:status])

      order
    end

    def destroy(order_id)
      @order_id = order_id
      order.update(status: :cancelled)

      order
    end

    def add_log(order_id, log_description)
      @order_id = order_id
      order.order_logs.create(description: log_description)
    end

    private

    attr_reader :user, :order_id

    def order
      @order ||= user.orders.find_by(uuid: order_id)
    end
  end
end
