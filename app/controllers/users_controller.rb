class UsersController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]

  def show
    @user = User.find_by(id: params[:id])
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to(practice_records_path)
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def redirect_if_logged_in
    if current_user
      redirect_to user_path(current_user)
    end
  end
end
