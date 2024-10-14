class UserPasswordResetsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :edit, :create, :update]

  def new; end

  def create
    user = User.find_by(email: user_password_reset_params[:email])
    if user
      @password_reset_instance = user.password_resets.build(
        reset_password_token: SecureRandom.urlsafe_base64,
        reset_password_sent_at: Time.zone.now
      )
      if @password_reset_instance.save
        UserMailer.password_reset(@password_reset_instance).deliver_now
        flash[:success] = 'パスワード再設定用のメールを送信しました。'
        redirect_to password_forgot_path
      else
        flash.now[:alert] = 'パスワード再設定用のメールの送信に失敗しました。'
        flash.now[:alert_detail] = "お手数ですが、再度お試しください。"
        render :new, status: :internal_server_error
      end
    else
      flash.now[:alert] = 'パスワード再設定用のメールの送信に失敗しました。'
      flash.now[:alert_detail] = 'メールアドレスが見つかりませんでした。'
      render :new, status: :not_found
    end
  end

  def edit
    @password_reset_instance = UserPasswordReset.find_by!(reset_password_token: params[:token])
    @user = @password_reset_instance.user
  end

  def update
    @password_reset_instance = UserPasswordReset.find_by!(reset_password_token: params[:token])
    @user = @password_reset_instance.user

    if params[:password].empty?
      flash.now[:alert] = 'パスワードを入力してください。'
      render :edit, status: :bad_request
    end

    if @user.update(password: params[:password])
      flash[:success] = 'パスワードを再設定しました。再度ログインをお願いします。'
      redirect_to login_path
    else
      flash.now[:alert] = 'パスワードの再設定に失敗しました。'
      render :edit, status: :internal_server_error
    end
  end

  def user_password_reset_params
    params.permit(:email, :password_digest)
  end
end
