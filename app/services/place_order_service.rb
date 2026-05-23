class PlaceOrderService
  class CartEmptyError < StandardError; end
  class StockShortageError < StandardError; end

  def self.call(user:, address:)
    new(user: user, address: address).call
  end

  def initialize(user:, address:)
    @user = user
    @address = address
  end

  def call
    load_cart!

    Order.transaction do
      validate_stock!
      total = calculate_total
      create_order!(total: total)
      create_order_items_and_decrement_stock!
      clear_cart!
    end

    send_confirmation_email

    ServiceResult.success(@order)
  rescue CartEmptyError, StockShortageError => e
    ServiceResult.failure(e.message)
  end

  private

  def load_cart!
    @cart = @user.cart
    raise CartEmptyError, 'カートが空です' if @cart.nil? || @cart.cart_items.empty?
  end

  def validate_stock!
    @cart.cart_items.includes(:product).each do |item|
      raise StockShortageError, "在庫が不足しています: #{item.product.name}" if item.product.stock < item.quantity
    end
  end

  def calculate_total
    @cart.cart_items.includes(:product).sum do |item|
      item.product.price_cents * item.quantity
    end
  end

  def create_order!(total:)
    @order = Order.create!(
      user: @user,
      address: @address,
      status: 'pending',
      total_cents: total
    )
  end

  def create_order_items_and_decrement_stock!
    @cart.cart_items.includes(:product).each do |item|
      @order.order_items.create!(
        product: item.product,
        quantity: item.quantity,
        price_cents: item.product.price_cents
      )
      item.product.update!(stock: item.product.stock - item.quantity)
    end
  end

  def clear_cart!
    @cart.cart_items.destroy_all
  end

  def send_confirmation_email
    SendOrderConfirmationEmailJob.perform_later(@order.id)
  end
end
