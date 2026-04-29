class UsersController < ApplicationController
  def index
    users = User.all
    render json: users
  end

  def show
    user = User.find(params[:id])
    render json: user
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Not Found' }, status: :not_found
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_content
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :age)
  end
end
