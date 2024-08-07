class UserMailer < ApplicationMailer
  # TODO: 本番環境でのメール送信を有効にする
  default from: 'no-reply@gyraph.com'

  def account_activation(user)
    @user = user
    @url = Rails.application.routes.url_helpers.login_url(
      host: Rails.application.config.action_mailer.default_url_options[:host],
      port: Rails.application.config.action_mailer.default_url_options[:port],
      protocol: Rails.application.config.action_mailer.default_url_options[:protocol]
    )
    mail(to: @user.email, subject: 'Gyraphへのご登録ありがとうございます')
  end
end
