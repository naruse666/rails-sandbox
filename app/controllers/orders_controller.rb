class OrdersController < ApplicationController
  def index
    @orders = Current.user.orders.order(created_at: :desc)
  end

  def show
    @order = Current.user.orders.find(params[:id])
  end

  def create
    address = Current.user.address
    if address.nil?
      redirect_to new_address_path, alert: '配送先を登録してください'
      return
    end

    result = PlaceOrderService.call(user: Current.user, address: address)

    if result.success?
      redirect_to order_path(result.value), notice: '注文が確定しました'
    else
      redirect_to cart_path, alert: result.error
    end
  end

  def cancel
    order = Current.user.orders.find(params[:id])

    result = CancelOrderService.call(order: order)
    if result.success?
      redirect_to order_path(order), notice: '注文をキャンセルしました'
    else
      redirect_to order_path(order), alert: result.error
    end
  end
end
