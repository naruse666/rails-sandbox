class Admin::ProductsController < ApplicationController
  def index
    @products = ProductSearchQuery.call(params: params)
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
