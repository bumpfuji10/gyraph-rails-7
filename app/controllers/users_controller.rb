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

  def edit
    @user = User.includes(:practice_records).find_by(id: params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      redirect_to(login_path)
      flash[:success] = "アカウントの仮登録が完了しました。メールを確認してアカウントを有効化してください"
    else
      render(:new, status: :unprocessable_entity)
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update(user_params)
    if @user.save
      flash[:success] = "プロフィールを更新しました"
      redirect_to(user_path(@user))
    else
      flash.now[:alert] = "プロフィールを更新できませんでした"
      flash.now[:alert_detail] = @user.errors.full_messages.join("\n")
      render(:edit, status: :unprocessable_entity)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :profile, :icon)
  end

  def redirect_if_logged_in
    if current_user
      redirect_to(practice_records_path)
    end
  end
end
