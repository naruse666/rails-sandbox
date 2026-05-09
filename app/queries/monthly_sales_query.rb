class MonthlySalesQuery
  def self.call(year:, month:)
    new(year: year, month: month).call
  end

  def initialize(year:, month:)
    @year = year
    @month = month
  end

  def call
    {
      total_sales_cents: total_sales_cents,
      order_count: order_count,
      sales_by_product: sales_by_product
    }
  end

  private

  def base_scope
    Order.where(status: %w[paid shipped completed]).where(created_at: range)
  end

  def range
    start_of_month = Date.new(@year, @month, 1).beginning_of_day
    end_of_month = start_of_month.end_of_month.end_of_day

    start_of_month..end_of_month
  end

  def total_sales_cents
    base_scope.sum(:total_cents)
  end

  def order_count
    base_scope.count
  end

  def sales_by_product
    OrderItem.joins(:order, :product)
             .where(order: base_scope)
             .group('products.name')
             .sum('order_items.price_cents * order_items.quantity')
             .sort_by { |_name, total| -total }
             .to_h
  end
end
