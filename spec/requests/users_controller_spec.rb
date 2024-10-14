require 'rails_helper'

RSpec.describe UsersController, type: :request do

  describe "index" do

    context "ログインしている場合" do
      let(:user) { FactoryBot.create(:user) }

      before { post '/login', params: { email: user.email, password: 'password' } }

      it "ステータスコード200" do
        get("/users")
        expect(response.status).to eq 200
      end
    end

    context "ログインしていない場合" do
      it "ステータスコード302" do
        get("/users")
        expect(response.status).to eq 302
      end
    end
  end

  describe "new" do
    let(:user) { FactoryBot.create(:user) }

    context "ログインしている場合" do
      before { post '/login', params: { email: user.email, password: 'password' } }

      it "ステータスコード302" do
        get("/users/new")
        expect(response.status).to eq 302
      end
    end
  end

  context "ログインしていない場合" do
    it "ステータスコード200" do
      get("/users/new")
      expect(response.status).to eq 200
    end
  end

  describe "show" do
    let(:user) { FactoryBot.create(:user) }

    context "ログインしている場合" do

      before { post '/login', params: { email: user.email, password: 'password' } }

      it "ステータスコード200" do
        get("/users/#{user.id}")
        expect(response.status).to eq 200
      end
    end

    context "ログインしていない場合" do
      it "ステータスコード200" do
        get("/users/#{user.id}")
        expect(response.status).to eq 302
      end
    end


  end

  describe "create" do
    let(:user) { FactoryBot.create(:user) }

    context "ログインしている場合" do
      before { post '/login', params: { email: user.email, password: 'password' } }

      context "valid params" do
        let(:params) {
          {
            user: {
              name: "testくん",
              email: "test@testhoge.com",
              password: "password"
            }
          }
        }
        let(:request) { post("/users", params: params) }

        it "ステータスコード302" do
          request
          expect(response.status).to eq 302
        end

        it "Userインスタンス1増加" do
          expect { request }.to change { User.count }.by(0)
        end
      end

      context "invalid params" do
        let(:params) {
          {
            user: {
              name: nil,
              email: nil,
              password: nil
            }
          }
        }
        let(:request) { post("/users", params: params) }

        it "ステータスコード302" do
          request
          expect(response.status).to eq 302
        end

        it "Userインスタンス変動なし" do
          request
          expect { request }.to change { User.count }.by(0)
        end
      end
    end

    context "ログインしていない場合" do

      let(:params) {
        {
          user: {
            name: "testくん",
            email: "test@testhoge.com",
            password: "password"
          }
        }
      }
      let(:request) { post("/users", params: params) }

      it "ステータスコード302" do
        request
        expect(response.status).to eq 302
      end

      it "Userインスタンス変動1増加" do
        expect { request }.to change { User.count }.by(1)
      end

      it "params通りにUserインスタンスが作成されている" do
        request
        User.last.tap do |user|
          expect(user.name).to eq params[:user][:name]
          expect(user.email).to eq params[:user][:email]
        end
      end
    end
  end

  describe "GET /users/:id/edit" do
    let(:user) { FactoryBot.create(:user) }
    let(:request) { get("/users/#{user.id}/edit") }

    context "ログインしている場合" do
      before do
        post '/login', params: { email: user.email, password: 'password' }
      end

      it "ステータスコード200" do
        request
        expect(response.status).to eq 200
      end
    end

    context "ログインしていない場合" do

      it "ステータスコード302" do
        request
        expect(response.status).to eq 302
      end
    end
  end

  describe "PATCH /users/:id" do
    let(:user) { FactoryBot.create(:user) }

    context "ログインしている場合" do
      before { post '/login', params: { email: user.email, password: 'password' } }

      context "適切なparams" do
        let(:params) {
          {
          user: {
              name: "田中太郎",
              email: "tanaka@tarou.com"
            }
          }
        }

        it "ステータスコード302" do
          patch("/users/#{user.id}", params: params)
          expect(response.status).to eq 302
        end

        it "ユーザーの情報が更新されていること" do
          patch("/users/#{user.id}", params: params)
          user.reload

          expect(user.name).to eq params[:user][:name]
          expect(user.email).to eq params[:user][:email]
        end
      end

      context "適切ではないparams" do
        let(:invalid_params) {
          {
          user: {
              name: nil,
              email: nil
            }
          }
        }

        it "ステータスコード422" do
          patch("/users/#{user.id}", params: invalid_params)
          expect(response.status).to eq 422
        end

        it "ユーザーの情報が更新されていないこと" do
          patch("/users/#{user.id}", params: invalid_params)
          expect(user.name).not_to eq nil
          expect(user.email).not_to eq nil
        end
      end
    end

    context "ログインしていない場合" do

      let(:params) {
        {
        user: {
            name: "田中太郎",
            email: "tanaka@tarou.com"
          }
        }
      }

      it "ステータスコード302" do
        patch("/users/#{user.id}", params: params)
        expect(response.status).to eq 302
      end

      it "ユーザーの情報が更新されていないこと" do
        patch("/users/#{user.id}", params: params)
        user.reload
        expect(user.name).not_to eq params[:user][:name]
        expect(user.email).not_to eq params[:user][:email]
      end
    end
  end

end
