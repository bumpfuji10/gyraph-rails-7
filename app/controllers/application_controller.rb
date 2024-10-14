class ApplicationController < ActionController::Base
  helper_method :current_user

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def redirect_if_not_logged_in
    if !current_user
      flash[:alert] = "ログインしてください"
      redirect_to root_path
    end
  end

  def redirect_if_logged_in
    if current_user
      flash[:alert] = "すでにログインしています"
      redirect_to practice_records_path
    end
  end
end
