require 'rails_helper'

RSpec.describe AccountActivationsController, type: :request do
  include ActiveSupport::Testing::TimeHelpers
  let(:user) { FactoryBot.create(:user, confirmation_token: "valid_token") }

  before { freeze_time}
  after { unfreeze_time }

  describe "edit" do

    context "トークンが有効期限内" do
      before { freeze_time }

      it "アカウントを有効化し、ログインページにリダイレクトする" do
        get "/account_activations/#{user.confirmation_token}"
        expect(response).to redirect_to(login_path)
        expect(flash[:success]).to eq "アカウントを有効化しました。お手数ですが、再度ログインしてください。"
      end

      it "confirmed_atが現在時刻に更新されている" do
        get "/account_activations/#{user.confirmation_token}"
        expect { user.reload }.to change { user.confirmed_at }.from(nil).to(Time.current)
      end

      it "confirmation_tokenがnilになっている" do
        get "/account_activations/#{user.confirmation_token}"
        user.reload
        expect(user.confirmation_token).to be_nil
      end
    end

    context "トークンが有効期限切れ" do
      before do
        user.update(confirmation_sent_at: 61.minutes.ago)
      end

      it "アカウントが削除されていること" do
        get "/account_activations/#{user.confirmation_token}"
        expect { user.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end

      it "新規登録画面にリダイレクト" do
        get "/account_activations/#{user.confirmation_token}"
        expect(response).to redirect_to(signup_path)
      end

      it "エラーメッセージが表示されている" do
        get "/account_activations/#{user.confirmation_token}"
      end
    end
  end
end
