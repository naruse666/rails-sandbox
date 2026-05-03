class AddressesController < ApplicationController
  before_action :set_address, only: %i[edit update]

  def new
    @address = Current.user.build_address
  end

  def create
    @address = Current.user.build_address(address_params)
    if @address.save
      redirect_to cart_path, notice: '配送先を登録しました'
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to cart_path, notice: '配送先を更新しました'
    else
      render :edit, status: :unprocessable_content
    end
  end

  private

  def set_address
    @address = Current.user.address
  end

  def address_params
    params.require(:address).permit(:postal_code, :prefecture, :city, :street)
  end
end
