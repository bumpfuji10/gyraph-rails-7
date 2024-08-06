class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(confirmation_token: params[:token])

    if user.nil?
      redirect_to signup_path
      flash[:alert] = "アカウントの有効化に失敗しました"
      flash[:alert_detail] = "アカウントが存在しないか、URLが間違っています。大変お手数ですが、再度登録をお願いいたします。"
    elsif user.expired?
      user.destroy
      redirect_to signup_path
      flash[:alert] = "アカウントの有効化に失敗しました"
      flash[:alert_detail] = "アカウントの有効化URLの有効期限が切れています。大変お手数ですが、再度登録をお願いいたします。"
    else
      user.confirm
      redirect_to(login_path)
      flash[:success] = "アカウントを有効化しました。お手数ですが、再度ログインしてください。"
    end
  end
end
