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
end
