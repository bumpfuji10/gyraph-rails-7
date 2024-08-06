require 'rails_helper'

RSpec.describe User, type: :model do
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
    end
  end

  describe "generate_confirmation_instructions" do

    it "confirmation_tokenが生成される" do

    end
    it "confirmation_sent_atが現在時刻で記録される" do

    end
  end

  describe "confirm" do

    it "userのconfirmed_atが現在時刻で記録される" do

    end

    it "userのconirmatin_tokenがnilになる" do

    end
  end

  describe "confirmed?" do

    context "confirmed_atがある場合" do

      it "return true" do

      end
    end

    context "confirmed_atが無い場合" do

      it "return false" do

      end
    end
  end
end
