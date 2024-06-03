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

    it "ステータスコード201" do
      request
      expect(response.status).to eq 201
    end

    it "Userインスタンス1増加" do
      expect { request }.to change { User.count }.by(1)
    end
  end

end
