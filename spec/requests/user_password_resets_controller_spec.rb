require 'rails_helper'

RSpec.describe "UserPasswordResets", type: :request do
  let(:user) { FactoryBot.create(:user, email: "test@user.com", password: "password") }

  describe "GET /password/forgot" do

    context "ログインしている場合" do
      before { post '/login', params: { email: user.email, password: 'password' } }

      it "ステータスコード302" do
        get("/password/forgot")
        expect(response.status).to eq 302
      end
    end

    context "ログインしていない場合" do

      it "ステータスコード200" do
        get("/password/forgot")
        expect(response.status).to eq 200
      end
    end
  end

  describe "POST /password/forgot" do

    context "ログインしている場合" do
      before do
        post '/login', params: { email: user.email, password: 'password' }
        ActionMailer::Base.deliveries.clear
      end

      it "ステータスコード302" do
        post("/password/forgot", params: { email: user.email })
        expect(response.status).to eq 302
      end

      it "メールが送信されないこと" do
        post("/password/forgot", params: { email: user.email })
        expect(ActionMailer::Base.deliveries.size).to eq 0
      end
    end

    context "ログインしていない場合" do

      context "メールアドレスが存在している場合" do

        it "ステータスコード302" do
          post("/password/forgot", params: { email: user.email })
          expect(response.status).to eq 302
        end

        it "メールが送信されること" do
          post("/password/forgot", params: { email: user.email })
          expect(ActionMailer::Base.deliveries.size).to eq 1
        end

        it "メールの内容が正しいこと" do
          post("/password/forgot", params: { email: user.email })
          expect(ActionMailer::Base.deliveries.last.subject).to eq "Gyraph｜パスワードを再設定します。"
        end
      end

      context "メールアドレスが存在しない場合" do

        it "ステータスコード404" do
          post("/password/forgot", params: { email: "hogehoge@hogefuga.com" })
          expect(response.status).to eq 404
        end

        it "メールが送信されないこと" do
          post("/password/forgot", params: { email: "hogehoge@hogefuga.com" })
          expect(ActionMailer::Base.deliveries.size).to eq 0
        end

        it "エラーメッセージが表示されること" do
          post("/password/forgot", params: { email: "hogehoge@hogefuga.com" })
          expect(flash.now[:alert]).to eq "パスワード再設定用のメールの送信に失敗しました。"
          expect(flash.now[:alert_detail]).to eq "メールアドレスが見つかりませんでした。"
        end
      end

      context "なんらかの理由でpassword_reset_instanceの保存に失敗した場合" do
        before do
          allow_any_instance_of(UserPasswordReset).to receive(:save).and_return(false)
        end

        it "ステータスコード500が返されること" do
          post("/password/forgot", params: { email: user.email })
          expect(response.status).to eq 500
        end

        it "エラーメッセージが表示されること" do
          post("/password/forgot", params: { email: user.email })
          expect(flash.now[:alert]).to eq "パスワード再設定用のメールの送信に失敗しました。"
          expect(flash.now[:alert_detail]).to eq "お手数ですが、再度お試しください。"
        end
      end
    end
  end

  describe "GET password/reset/:token" do

    context "ログインしている場合" do
      before do
        post("/password/forgot", params: { email: user.email })
        post '/login', params: { email: user.email, password: 'password' }
      end

      it "ステータスコード302" do
        get("/password/reset/#{user.user_password_resets.last.reset_password_token}")
        expect(response.status).to eq 302
      end
    end

    context "ログインしていない場合" do
      before do
        post("/password/forgot", params: { email: user.email })
      end

      it "ステータスコード200" do
        get("/password/reset/#{user.user_password_resets.last.reset_password_token}")
        expect(response.status).to eq 200
      end
    end

    xcontext "PATCH /password/reset/:token" do

      context "ログインしている場合" do

        before do
          post("/password/forgot", params: { email: user.email })
          post '/login', params: { email: user.email, password: 'password' }
        end

        it "ステータスコード302" do
          patch("/password/reset/#{user.user_password_resets.last.reset_password_token}", params: { password: "newpassword" })
          expect(response.status).to eq 302
        end
      end

      context "ログインしていない場合" do

        context "適切なparams" do
          before do
            post("/password/forgot", params: { email: user.email })
          end

          it "ステータスコード302" do
            patch("/password/reset/#{user.user_password_resets.last.reset_password_token}", params: { password: "newpassword" })
            expect(response.status).to eq 302
          end

          it "パスワードが更新されていること" do
            patch("/password/reset/#{user.user_password_resets.last.reset_password_token}", params: { password: "newpassword" })
            user.reload
            expect(user.authenticate("newpassword")).to eq user
          end
        end

        context "パスワードが空の場合" do
          before do
            post("/password/forgot", params: { email: user.email })
          end

          it "パスワードが更新されていないこと" do
            patch("/password/reset/#{user.user_password_resets.last.reset_password_token}", params: { password: "" })
            expect(user.authenticate("password")).to eq user
          end
        end
      end
    end
  end
end
