require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  let(:user) { FactoryBot.create(:user, email: "test@user.com", password: "sessionpassword") }

  describe "GET /new" do

    context "ログインしている場合" do
      before { post '/login', params: { email: user.email, password: 'sessionpassword' } }

      it "ステータスコード302" do
        get("/login")
        expect(response.status).to eq 302
      end
    end

    context "ログインしていない場合" do

      it "ステータスコード200" do
        get("/login")
        expect(response.status).to eq 200
      end
    end
  end

  describe "POST /login" do

    context "ログインしている場合" do
      before { post '/login', params: { email: user.email, password: 'sessionpassword' } }

      it "ステータスコード302" do
        post("/login", params: { email: user.email, password: 'sessionpassword' })
        expect(response.status).to eq 302
      end
    end

    context "ログインしていない場合" do

      context "パスワードとメールアドレスが正しい場合" do
        let(:params) {
          {
            email: user.email,
            password: "sessionpassword"
          }
        }

        it "ステータスコード302" do
          post("/login", params: params)
          expect(response.status).to eq 302
        end

        it "ログイン成功のフラッシュメッセージが表示されること" do
          post("/login", params: params)
          expect(flash[:success]).to eq "ログインしました"
        end

        it "ログイン成功したときsession[:user_id]にユーザーIDがセットされること" do
          post("/login", params: params)
          expect(session[:user_id]).to eq user.id
        end
      end

      context "メールアドレスが正しくない場合" do
        let(:params) {
          {
            email: "hogehoge@hoge.com",
            password: "sessionpassword"
          }
        }

        it "ステータスコード422" do
          post("/login", params: params)
          expect(response.status).to eq 422
        end

        it "ログイン失敗のフラッシュメッセージが表示されること" do
          post("/login", params: params)
          expect(flash.now[:alert]).to eq "ログインできませんでした"
          expect(flash.now[:alert_detail]).to eq "メールアドレスまたはパスワードに<br>誤りがあります"
        end

        it "ログイン失敗したときsession[:user_id]にユーザーIDがセットされないこと" do
          post("/login", params: params)
          expect(session[:user_id]).to eq nil
        end
      end

      context "パスワードが正しくない場合" do
        let(:params) {
          {
            email: user.email,
            password: "wrongpassword"
          }
        }

        it "ステータスコード422" do
          post("/login", params: params)
          expect(response.status).to eq 422
        end

        it "ログイン失敗のフラッシュメッセージが表示されること" do
          post("/login", params: params)
          expect(session[:user_id]).to eq nil
        end
      end
    end
  end

  describe "DELETE /logout" do

    context "ログインしている場合" do
      before { post '/login', params: { email: user.email, password: 'password' } }

      it "ステータスコード302" do
        delete("/logout")
        expect(response.status).to eq 302
      end

      it "ログアウト成功のフラッシュメッセージが表示されること" do
        delete("/logout")
        expect(flash[:success]).to eq "ログアウトしました"
      end

      it "ログアウトしたときsession[:user_id]がnilになること" do
        delete("/logout")
        expect(session[:user_id]).to eq nil
      end
    end

    context "ログインしていない場合" do

      it "ステータスコード302" do
        delete("/logout")
        expect(response.status).to eq 302
      end
    end
  end
end
