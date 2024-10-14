class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def require_login
    unless logged_in?
      flash[:alert] = "ログインしてください"
      redirect_to login_path
    end
  end

  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "ログインしました"
      redirect_to(practice_records_path)
    else
      flash.now[:alert] = "ログインできませんでした"
      flash.now[:alert_detail] = "メールアドレスまたはパスワードに<br>誤りがあります"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
    flash[:success] = "ログアウトしました"
  end
end
