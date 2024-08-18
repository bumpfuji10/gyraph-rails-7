class UserPasswordResetsController < ApplicationController

  def new; end

  def create
    user = User.find_by(email: user_password_reset_params[:email])
    if user
      @password_reset_instance = user.password_resets.build(
        reset_password_token: SecureRandom.urlsafe_base64,
        reset_password_sent_at: Time.zone.now
      )
      if @password_reset_instance.save
        UserMailer.password_reset(password_reset_instance).deliver_now
        flash[:success] = 'パスワード再設定用のメールを送信しました。'
        redirect_to password_forgot_path
      else
        flash.now[:alert] = @password_reset_instance.errors.full_messages
        render :new
      end
    else
      flash.now[:alert] = 'パスワード再設定用のメールの送信に失敗しました。'
      flash.now[:alert_detail] = 'メールアドレスが見つかりませんでした。'
      render :new
    end
  end

  def edit
    @password_reset_instance = UserPasswordReset.find_by!(reset_password_token: params[:token])
    @user = @password_reset_instance.user
  end

  def update
    @password_reset_instance = UserPasswordReset.find_by!(reset_password_token: params[:token])
    user = @password_reset_instance.user
    if user.update!(password: params[:password])
      redirect_to login_path
      flash[:success] = 'パスワードを再設定しました。再度ログインをお願いします。'
    else
      render :edit
      flash.now[:alert] = 'パスワードの再設定に失敗しました。'
    end

  end

  def user_password_reset_params
    params.permit(:email, :password_digest)
  end
end
