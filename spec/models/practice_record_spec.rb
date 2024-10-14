require 'rails_helper'

RSpec.describe PracticeRecord, type: :model do
  describe "validation" do
    let(:user) { FactoryBot.create(:user) }

    describe "title" do

      context "titleあり" do
        let(:practice_record) { FactoryBot.build(:practice_record, user: user, title: "今日の練習") }

        it "作成成功" do
          expect(practice_record.save).to eq true
        end

        it "有効" do
          expect(practice_record).to be_valid
        end
      end

      context "titleなし" do
        let(:practice_record) { FactoryBot.build(:practice_record, user: user, title: nil) }

        it "作成失敗" do
          expect(practice_record.save).to eq false
        end

        it "無効" do
          expect(practice_record).to be_invalid
        end
      end

      context "practiced_dateあり" do
        let(:practice_record) { FactoryBot.build(:practice_record, user: user, practiced_date: "2025-05-05") }

        it "作成成功" do
          expect(practice_record.save).to eq true
        end

        it "有効" do
          expect(practice_record).to be_valid
        end
      end

      context "practiced_dateなし" do
        let(:practice_record) { FactoryBot.build(:practice_record, user: user, practiced_date: nil) }

        it "作成失敗" do
          expect(practice_record.save).to eq false
        end

        it "無効" do
          expect(practice_record).to be_invalid
        end
      end
    end
  end

  describe "methods" do

    describe "is_mine?" do
      let(:user) { FactoryBot.create(:user) }
      let(:other_user) { FactoryBot.create(:user, email: "other_user@test.com") }
      let(:practice_record) { FactoryBot.create(:practice_record, user: user) }

      context "自分の練習日誌の場合" do

        it "trueを返す" do
          expect(practice_record.is_mine?(user: user)).to eq true
        end

      end

      context "他人の練習日誌の場合" do

        it "falseを返す" do
          expect(practice_record.is_mine?(user: other_user)).to eq false
        end
      end
    end
  end
end
