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

    begin
      order = Order.place!(user: Current.user, address: address)
      redirect_to order_path(order), notice: '注文が確定しました'
    rescue StandardError => e
      redirect_to cart_path, alert: e.message
    end
  end

  def cancel
    order = Current.user.orders.find(params[:id])

    begin
      order.cancel!
      redirect_to order_path(order), notice: '注文をキャンセルしました'
    rescue StandardError => e
      redirect_to order_path(order), alert: e.message
    end
  end
end
