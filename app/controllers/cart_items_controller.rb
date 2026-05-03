class CartItemsController < ApplicationController
  def create
    cart = Current.user.cart || Current.user.create_cart!
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i
    quantity = 1 if quantity < 1

    if product.stock < quantity
      redirect_to product_path(product), alert: '在庫が不足しています'
      return
    end

    existing_item = cart.cart_items.find_by(product: product)
    if existing_item
      new_quantity = existing_item.quantity + quantity

      if product.stock < new_quantity
        redirect_to product_path(product), alert: '在庫が不足しています'
        return
      end

      existing_item.update!(quantity: new_quantity)
    else
      cart.cart_items.create!(product: product, quantity: quantity)
    end

    redirect_to cart_path, notice: 'カートに追加しました'
  end

  def update
    cart_item = Current.user.cart.cart_items.find(params[:id])
    new_quantity = params[:quantity].to_i
    if new_quantity < 1
      cart_item.destroy
      redirect_to cart_path, notice: '商品を削除しました'
      return
    end

    if cart_item.product.stock < new_quantity
      redirect_to cart_path, alert: '在庫が不足しています'
      return
    end

    cart_item.update!(quantity: new_quantity)
    redirect_to cart_path, notice: '数量を更新しました'
  end

  def destroy
    cart_item = Current.user.cart.cart_items.find(params[:id])
    cart_item.destroy
    redirect_to cart_path, notice: '商品を削除しました'
  end
end
