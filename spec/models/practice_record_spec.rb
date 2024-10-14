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

  describe "accepts_nested_attributes_for" do
    let(:practice_record) do
      FactoryBot.create(:practice_record, title: "本日の練習", practiced_date: Date.today)
    end

    context "practice_recordに対して適切ではないdetail.attributesが渡された場合" do

      it "practice_recordが更新されないこと" do
        result = practice_record.update(
          practice_record_details_attributes: [{
            activity_title: nil, content: nil
          }]
        )

        expect(result).to eq false
        expect(practice_record.details.count).to eq 0
      end
    end

    context "practice_recordに対して適切なdetail.attributesが渡された場合" do

      it "渡されたdetailの情報どおりにpractice_recordが更新されていること" do
        practice_record.update(
          practice_record_details_attributes: [{
            activity_title: "ゆか", content: "着地が動きまくって駄目だった。"
          }]
        )
        expect(practice_record.details.count).to eq 1
        expect(practice_record.details.first.activity_title).to eq "ゆか"
        expect(practice_record.details.first.content).to eq "着地が動きまくって駄目だった。"
      end
    end
  end
end
