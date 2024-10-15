require 'rails_helper'

RSpec.describe User, type: :model do
  include ActiveSupport::Testing::TimeHelpers

  describe "validates" do
    context "name" do
      let(:user_has_name) { FactoryBot.build(:user, name: "test user", email: "test@test.com") }

      context "nameがある場合" do

        it "userの作成に成功" do
          expect(user_has_name.save).to eq true
        end

        it "userが有効" do
          expect(user_has_name).to be_valid
        end
      end

      context "nameが無い場合" do
        let(:user_has_not_name) { FactoryBot.build(:user, name: nil, email: "test@test.com") }

        it "userの作成に失敗" do
          expect(user_has_not_name.save).to eq false
        end

        it "userが無効" do
          expect(user_has_not_name).to be_invalid
        end
      end
    end

    context "email" do

      context "emailがある場合" do
        let(:user_has_email) { FactoryBot.build(:user, name: "test user", email: "test@test.com") }

        it "userの作成に成功" do
          expect(user_has_email.save).to eq true
        end

        it "userが有効" do
          expect(user_has_email).to be_valid
        end
      end

      context "emailが無い場合" do
        let(:user_has_email) { FactoryBot.build(:user, name: "test user", email: nil) }

        it "userの作成に失敗" do
          expect(user_has_email.save).to eq false
        end

        it "userが無効" do
          expect(user_has_email).to be_invalid
        end
      end
    end

    context "password" do

      context "passwordがある場合" do
        let(:user_has_password) { FactoryBot.build(:user, name: "test user", email: "test@test.com", password: "password") }

        it "userの作成に成功" do
          expect(user_has_password.save).to eq true
        end

        it "userが有効" do
          expect(user_has_password).to be_valid
        end
      end

      context "passwordが無い場合" do
        let(:user_has_not_password) { FactoryBot.build(:user, name: "test user", email: "test@test.com", password: nil) }

        it "userの作成に失敗" do
          expect(user_has_not_password.save).to eq false
        end

        it "userが無効" do
          expect(user_has_not_password).to be_invalid
        end
      end

      context "passwordが8文字以上" do
        let(:user) { FactoryBot.build(:user, name: "test user", email: "test@test.com", password: "a" * 8) }

        it "userの作成に成功" do
          expect(user.save).to eq true
        end

        it "userが有効" do
          expect(user).to be_valid
        end
      end

      context "passwordが8文字未満" do
        let(:user) { FactoryBot.build(:user, name: "test user", email: "test@test.com", password: "a" * 7) }

        it "userの作成に失敗" do
          expect(user.save).to eq false
        end

        it "userが無効" do
          expect(user).to be_invalid
        end
      end
    end
  end

  describe "methods" do

    context "generate_confirmation_instructions" do
      let(:user) { FactoryBot.create(:user) }
      before { freeze_time }

      it "confirmation_tokenが生成される" do
        expect(user.confirmation_token).to be_present
      end

      it "confirmation_sent_atが現在時刻で記録される" do
        expect(user.confirmation_sent_at).to be_present
        expect(user.confirmation_sent_at).to eq Time.current
      end
    end

    context "confirm" do
      let(:already_sent_account_activation_mail_user) do
        user = FactoryBot.create(:user)
      end
      before { freeze_time }

      it "userのconfirmed_atが現在時刻で記録される" do
        already_sent_account_activation_mail_user.confirm
        expect(already_sent_account_activation_mail_user.confirmed_at).to eq Time.current
      end

      it "userのconirmatin_tokenがnilになる" do
        already_sent_account_activation_mail_user.confirm
        expect(already_sent_account_activation_mail_user.confirmation_token).to be_nil
      end
    end

    context "confirmed?" do
      let(:already_sent_account_activation_mail_user) do
        user = FactoryBot.create(:user)
        user.confirm
        user
      end

      context "confirmed_atがある場合" do

        it "return true" do
          expect(already_sent_account_activation_mail_user.confirmed?).to eq true
        end
      end

      context "confirmed_atが無い場合" do
        before { already_sent_account_activation_mail_user.confirmed_at = nil }

        it "return false" do
          expect(already_sent_account_activation_mail_user.confirmed?).to eq false
        end
      end
    end

    context "expired?" do
      before { freeze_time }
      let!(:user) { user = FactoryBot.create(:user) }

      context "userのconfirmation_sent_atが現在時刻から1時間以上前の場合" do
        before { travel 61.minutes }

        it "return true" do
          expect(user.expired?).to eq true
        end
      end

      context "userのconfirmation_sent_atが1時間前でない場合" do
        before { travel 59.minutes }

        it "return false" do
          expect(user.expired?).to eq false
        end
      end
    end
  end
end
