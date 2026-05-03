class CartsController < ApplicationController
  def show
    @cart = current_user_cart
  end

  private

  def current_user_cart
    Current.user.cart || Current.user.create_cart!
  end
end
