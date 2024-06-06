require 'rails_helper'

RSpec.describe UsersController, type: :request do
  describe "index" do
    it "ステータスコード200" do
      get("/users")
      expect(response.status).to eq 200
    end
  end

  describe "new" do
    it "ステータスコード200" do
      get("/users/new")
      expect(response.status).to eq 200
    end
  end

  describe "show" do
    let(:user) { FactoryBot.create(:user) }
    it "ステータスコード200" do
      get("/users/#{user.id}")
      expect(response.status).to eq 200
    end
  end

  describe "create" do

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
        expect { request }.to change { User.count }.by(1)
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

      it "ステータスコード422" do
        request
        expect(response.status).to eq 422
      end

      it "Userインスタンス変動なし" do
        request
        expect { request }.to change { User.count }.by(0)
      end
    end
  end

end
