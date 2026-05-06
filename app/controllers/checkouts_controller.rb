class CheckoutsController < ApplicationController
  def new
    @checkout = Checkout.new(user: Current.user, **address_attributes_from_user)
    @cart = Current.user.cart
  end

  def create
    @checkout = Checkout.new(checkout_params.merge(user: Current.user))

    if @checkout.save
      redirect_to order_path(@checkout.order), notice: '注文が確定しました'
    else
      @cart = Current.user.cart
      render :new, status: :unprocessable_content
    end
  end

  private

  def checkout_params
    params.require(:checkout).permit(:postal_code, :prefecture, :city, :street)
  end

  def address_attributes_from_user
    address = Current.user.address
    return {} unless address

    {
      postal_code: address.postal_code,
      prefecture: address.prefecture,
      city: address.city,
      street: address.street
    }
  end
end
