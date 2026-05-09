class ProductSearchQuery
  def self.call(scope: Product.all, params: {})
    new(scope: scope, params: params).call
  end

  def initialize(scope:, params:)
    @scope = scope
    @params = params
  end

  def call
    relation = @scope
    relation = filter_by_keyword(relation)
    relation = filter_by_price_range(relation)
    relation = filter_by_stock_status(relation)
    order_by(relation)
  end

  private

  def filter_by_keyword(relation)
    return relation if @params[:keyword].blank?

    relation.where('name LIKE ?', "%#{@params[:keyword]}%")
  end

  def filter_by_price_range(relation)
    relation = relation.where('price_cents >= ?', @params[:min_price].to_i * 100) if @params[:min_price].present?
    relation = relation.where('price_cents <= ?', @params[:max_price].to_i * 100) if @params[:max_price].present?
    relation
  end

  def filter_by_stock_status(relation)
    case @params[:stock_status]
    when 'in_stock'
      relation.where('stock > 0')
    when 'out_of_stock'
      relation.where(stock: 0)
    else
      relation
    end
  end

  def order_by(relation)
    case @params[:sort]
    when 'price_asc'
      relation.order(price_cents: :asc)
    when 'price_desc'
      relation.order(price_cents: :desc)
    when 'stock_desc'
      relation.order(stock: :desc)
    else
      relation.order(created_at: :desc)
    end
  end
end
