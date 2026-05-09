class Admin::ProductsController < ApplicationController
  def index
    @products = Product.all

    @products = @products.where('name LIKE ?', "%#{params[:keyword]}%") if params[:keyword].present?

    # price range
    @products = @products.where('price_cents >= ?', params[:min_price].to_i * 100) if params[:min_price].present?
    @products = @products.where('price_cents >= ?', params[:max_price].to_i * 100) if params[:max_price].present?

    # stock
    case params[:stock_status]
    when 'in_stock'
      @products = @products.where('stock > 0')
    when 'out_of_stock'
      @products = @products.where(stock: 0)
    end

    # sort
    @products = case params[:sort]
                when 'price_asc'
                  @products.order(price_cents: :asc)
                when 'price_desc'
                  @products.order(price_cents: :desc)
                when 'stock_desc'
                  @products.order(stock: :desc)
                else
                  @products.order(created_at: :desc)
                end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to admin_products_path, notice: '商品を更新しました'
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price_cents, :stock)
  end
end
