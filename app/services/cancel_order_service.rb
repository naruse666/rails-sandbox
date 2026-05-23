# frozen_string_literal: true

class CancelOrderService
  class NotCancellableError < StandardError; end

  def self.call(order:)
    new(order: order).call
  end

  def initialize(order:)
    @order = order
  end

  def call
    ensure_cancellable!

    Order.transaction do
      revert_stock!
      @order.transition_to!('cancelled')
    end

    ServiceResult.success
  rescue NotCancellableError => e
    ServiceResult.failure(e.message)
  end

  private

  def ensure_cancellable!
    raise NotCancellableError, 'この注文はキャンセルできません' unless @order.cancellable?
  end

  def revert_stock!
    @order.order_items.includes(:product).each do |item|
      item.product.update!(stock: item.product.stock + item.quantity)
    end
  end
end
